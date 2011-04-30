class Setup  
  class << self 
    def start
      check_requirements
      load_libraries
      initialize_db
      load_app
    end

    def load_app
      Dir["#{File.dirname(__FILE__)}/../app/**/*.rb"].sort.each { |file| require file }
    end

    def load_libraries
      require 'rubygems'
      require 'bundler'
      Bundler.require(:default, ENV['RACK_ENV'])
    end


    def initialize_connection_mongodb
      if ENV['MONGOHQ_URL']
        config.master = Mongo::Connection.from_uri("mongodb://#{ENV['MONGOHQ_URL']}")      
      end
    end

  end
end