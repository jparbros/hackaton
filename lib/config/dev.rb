module FoodFinder::Config
  module Dev
    include FoodFinder::Config::Environment 

    def database_url
      "mongodb://localhost:27017"
    end

    def database_name
      "foodfinder"
    end

    def auth_url
      'https://foursquare.com/oauth2'
    end

    def api_url
      "https://api.foursquare.com/v2"
    end

    def client_id
      'M3Z2OBWQB4RPYNY22S112I4DVI5W4VQB5LRDJRPGEK1LK5RO'
    end

    def secret
      '53BWA4J3YLU4ZEM2NNNAHFQMG0AOAZ3GRO25UBRD5OFAWGLC'
    end

  end
end
