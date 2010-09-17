require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'pg_typecast'
    gem.summary     = %q{Extensions to pg gem supporting typecasting.}
    gem.description = %q{Extensions to pg gem supporting typecasting.}
    gem.email       = %w{deepfryed@gmail.com}
    gem.homepage    = 'http://github.com/deepfryed/pg_typecast'
    gem.authors     = ['Bharanee Rathna']
    gem.extensions  = FileList['ext/extconf.rb']
    gem.files.reject!{|f| f =~ %r{\.gitignore}}

    gem.add_dependency 'pg', '>= 0.9.0'

    gem.required_ruby_version = '>= 1.9.1'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :test    => :check_dependencies
task :default => :test
