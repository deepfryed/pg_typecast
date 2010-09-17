require_relative 'helper'

describe 'typecasting' do
  before do
    @db = PGconn.connect 'host=127.0.0.1 dbname=test'
    @db.exec %q{drop table if exists users}
    @db.exec %q{
      create table users(
        id      serial,
        name    text,
        age     integer,
        height  float,
        hacker  bool,
        slacker bool,
        nil     text default null,
        created date not null default now(),
        updated timestamp with time zone not null default now()
      )
    }

    bind = [ 'jim', 32, 178.71, true, false ]
    @db.exec %q{insert into users(name,age,height,hacker,slacker) values($1, $2, $3, $4, $5)}, bind
  end

  it 'should typecast correctly' do
    result = @db.exec(%q{select * from users limit 1}).first
    assert_kind_of Integer,    result[:id]
    assert_kind_of String,     result[:name]
    assert_kind_of Integer,    result[:age]
    assert_kind_of Float,      result[:height]
    assert_kind_of TrueClass,  result[:hacker]
    assert_kind_of FalseClass, result[:slacker]
    assert_kind_of Date,       result[:created]
    assert_kind_of Time,       result[:updated]
    assert_equal   nil,        result[:nil]
  end

  it 'should cascade exceptions in yield' do
    assert_raises(RuntimeError) do
      @db.exec(%q{select * from users limit 1}).each { raise "foo" }
    end
  end
end
