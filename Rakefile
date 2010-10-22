require(File.join(File.dirname(__FILE__), 'config', 'boot'))

desc "Start app"
task :start do
  ENV['APP_ENV'] ||= 'development'
  exec "thin -R config.ru --environment #{ENV['APP_ENV']} --port=3333 start"
end
