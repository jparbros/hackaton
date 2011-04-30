class Setup  
  class ActiveRecordConfigFile < Exception ; end

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
      mongoid_conf = storage_config
      Mongoid.configure do |config|
        config.master = Mongo::Connection.from_uri("mongodb://#{mongoid_conf['host']}:#{mongoid_conf['port']}").db(mongoid_conf['database'])
      end
    end

    def storage_config
      @config ||= YAML.load_file(File.dirname(__FILE__) + '/../config/mongodb.yml')[ENV['SINATRA_ENV']]
    end

    def check_requirements
      raise ActiveRecordConfigFile.new('Config file not found') unless Dir.getwd + '/../config/mongodb.yml'
    end
  end
end