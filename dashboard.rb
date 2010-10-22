require File.join(File.dirname(__FILE__), 'config', 'boot')

module Dashboard
  class Api < Sinatra::Base

    post '/builds' do
      data = YAML.load_file('data/dataset.yml')
      halt 400, '☠ bad request' unless params.any? 

      data[params.delete('name')].merge!(params)
      File.open('dataset.yml','w+') { |file| file.write data.to_yaml}
      "✓ status updated"
    end

    get '/' do
      data = YAML.load_file('data/dataset.yml')
      @projects = data.map do |k,v|
        project = OpenStruct.new(v)
        project.name = k
        project
      end
      haml :index
    end

    get '/application.css' do
      sass :style
    end
  end
end
