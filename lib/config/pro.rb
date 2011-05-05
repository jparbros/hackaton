module FoodFinder::Config
  module Pro
    include FoodFinder::Config::Environment 

    def database_url
      @db_url ||= ENV['MONGOHQ_URL']
    end

    def database_name
      @db_name ||= URI.parse(ENV['MONGOHQ_URL']).path.gsub(/^\//, '')
    end

  end
end
