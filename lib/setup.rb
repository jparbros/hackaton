class Setup  
  class << self 
    def start
      load_libraries
      initialize_db
      load_app

      configure do
        set :haml, { :format => :html5 }
      end
    end

    def load_app
      Dir["#{File.dirname(__FILE__)}/../app/**/*.rb"].sort.each { |file| require file }
    end

    def load_libraries
      require 'rubygems'
      require 'bundler'
      Bundler.require(:default, ENV['RACK_ENV'])
    end


    def initialize_db
      Mongoid.configure do |config|
        if ENV['MONGOHQ_URL']
          conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
          uri = URI.parse(ENV['MONGOHQ_URL'])
          config.master = conn.db(uri.path.gsub(/^\//, ''))
        else
          name = "foodfinder#{settings.environment}"
          config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db(name)
        end
      end
    end

  end
end
