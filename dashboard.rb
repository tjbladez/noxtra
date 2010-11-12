require File.join(File.dirname(__FILE__), 'config', 'boot')

module Dashboard
  class Api < Sinatra::Base

    post '/builds' do
      begin
        data = YAML.load_file('data/dataset.yml')
        halt 400, '☠ bad request' unless params.any?

        app_name = params.delete('name')
        update_digest(app_name, params)
        data[app_name].merge!(params)
        update_file("data/dataset.yml", data)
        "✓ status updated"
      rescue Exception => e
        halt 400, "☠ bad params"
      end
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

  private

    def update_file(filepath, data)
      File.open(filepath,'w+') { |file| file.write data.to_yaml} if ENV['APP_ENV'] != 'test'
    end

    def update_digest(app, params)
      data = YAML.load_file('data/digest.yml')
      data[app] ||= []
      data[app] << {"time" => Time.now.strftime("%H:%M:%S")}.merge!(params)
      update_file("data/digest.yml", data)
    end
  end
end
