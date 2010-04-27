require 'sinatra/base'
require 'ostruct'
require 'activerecord'
module Dashboard
  class Api < Sinatra::Base
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :dbfile =>  'dashboard_app.sqlite3.db'
    )

    class Project < ActiveRecord::Base
      attr_accessor :name, :status, :latest_sha
    end

    post '/builds' do
      "Passed in params are #{params.inspect}"
    end

    get '/' do
      @projects = [OpenStruct.new(:status => 'ready', :name => 'test', :latest_sha => '123123' ),
                   OpenStruct.new(:status => 'ready', :name => 'test2', :latest_sha => '23' )]
      haml :index
    end
  end
end
