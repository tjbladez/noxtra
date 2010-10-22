require(File.join(File.dirname(__FILE__), 'config', 'boot'))
require 'rake'
require 'rake/testtask'

desc "Start app"
task :start do
  ENV['APP_ENV'] ||= 'development'
  exec "thin -R config.ru --environment #{ENV['APP_ENV']} --port=3333 start"
end

desc "Test that thing"
task :test
Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end