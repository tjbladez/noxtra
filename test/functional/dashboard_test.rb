require File.expand_path(File.dirname(__FILE__) + '/../teststrap')

context "Dashboard::Api" do
  setup { @app = Dashboard::Api }
  
  context "on POST to /builds without params" do
    setup { post '/builds'}
    asserts(:status).equals(400)
    asserts(:body).equals "☠ bad request"
  end
  
  context "on POST to /build with correct params" do
    setup { post "/builds", "name" => "project1","status" => "pass", "sha" => "somesha"}
    asserts(:status).equals(200)
    asserts(:body).equals "✓ status updated"
  end
end