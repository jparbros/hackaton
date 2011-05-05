module FoodFinder
  module Config
    extend self

    def method_missing(name)
      @env ||= (ENV['RACK_ENV'] || 'dev')[0..2]
      require "config/#{@env}"
      config_module = "FoodFinder/Config/#{@env}".camelize.constantize
      FoodFinder::Config.extend config_module
      respond_to?(name) ? send(name) : super
    end

    module Environment
      def database_url
        raise "you must implement #{__method__} method"
      end

      def database_name
        raise "you must implement #{__method__} method"
      end

      def auth_url
        raise "you must implement #{__method__} method"
      end

      def api_url
        raise "you must implement #{__method__} method"
      end

      def client_id
        raise "you must implement #{__method__} method"
      end

      def secret
        raise "you must implement #{__method__} method"
      end
    end
  end
end
