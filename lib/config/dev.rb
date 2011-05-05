module FoodFinder::Config
  module Dev
    include FoodFinder::Config::Environment 

    def database_url
      "mongodb://localhost:27017"
    end

    def database_name
      "foodfinder"
    end
  end
end
