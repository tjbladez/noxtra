require 'dashboard'
use Rack::Auth::Basic do |username, password|
  username == 'user' && password == 'secret'
end
run Dashboard::Api