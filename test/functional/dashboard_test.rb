require File.expand_path(File.dirname(__FILE__) + '/../teststrap')
require 'dashboard'

context "Dashboard::Api" do
  setup { @app = Dashboard::Api }

  context "on POST to /builds without params" do
    setup { post '/builds'}
    asserts(:status).equals(400)
    asserts(:body).equals "☠ bad request"
  end

  context "on POST to /build with bad params" do
    setup { post "/builds", 'I intend to live forever' => 'So far, so good'}
    asserts(:status).equals(400)
    asserts(:body).equals "☠ bad params"
  end

  context "on POST to /build with correct params" do
    setup { post "/builds", "name" => "comradefy","status" => "pass", "sha" => "somesha", "author" => "nick", "message" => "test"}
    asserts(:status).equals(200)
    asserts(:body).equals "✓ status updated"
  end
end