require 'dashboard'
use Rack::Auth::Basic do |username, password|
  username == 'ci' && password == 'transis'
end
run Dashboard::Api