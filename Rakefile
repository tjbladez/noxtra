require(File.join(File.dirname(__FILE__), 'config', 'boot'))
require 'rake'
require 'rake/testtask'

desc "Run tests by default"
task :default => [:test]

desc "Start app"
task :start do
  ENV['APP_ENV'] ||= 'development'
  exec "thin -R config.ru --environment #{ENV['APP_ENV']} --port=3333 start"
end

desc "Setting env to be test"
task :test_env do
  ENV['APP_ENV'] = 'test'
end

desc "Test that thing"
task :test => [:test_env]
Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

desc "Deployment"
task :deploy do
  commands = [
      'cd /mylocation/noxtra',
      'git fetch',
      'git checkout -f origin/master',
      'mkdir -p public',
      'mkdir -p tmp',
      'bundle install --deployment',
      'touch tmp/restart.txt'
    ]
  puts "Deplying..."
  exec "ssh myuser@myhost '#{commands.join(' && ')}'"
end
