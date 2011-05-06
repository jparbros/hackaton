class Setup  
  class << self 
    def start
      load_libraries
      load_app
      initialize_db
      config_sessions
    end

    def load_app
      dir = File.dirname __FILE__
      $LOAD_PATH.unshift dir
      libraries = File.join dir, '*.rb'
      app = File.join dir, '..', 'app', '**', '*.rb'
      Dir[libraries, app].sort.each { |file| require file }
    end

    def load_libraries
      require 'rubygems'
      require 'bundler'
      Bundler.require(:default, ENV['RACK_ENV'])
    end

    def initialize_db
      Mongoid.logger = Logger.new($stdout)
      Mongoid.configure do |config|
        conn = Mongo::Connection.from_uri(FoodFinder::Config.database_url)
        config.master = conn.db FoodFinder::Config.database_name
      end
    end

    def config_sessions
      Sinatra::Base.use Rack::Session::Mongo, 
        :connection => Mongoid.config.master.connection, 
        :expire_after => 1800, :db => FoodFinder::Config.database_name
    end

  end
end

Setup.start
