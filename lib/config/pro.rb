module FoodFinder::Config
  module Pro
    include FoodFinder::Config::Environment 

    def database_url
      @db_url ||= ENV['MONGOHQ_URL']
    end

    def database_name
      @db_name ||= URI.parse(ENV['MONGOHQ_URL']).path.gsub(/^\//, '')
    end

    def client_id
      'OV2JAFIF2GDGDROUREBHZXGVXYEONWYMC3XRKYRESWWD5JA0'
    end

    def secret
      'SQYIFHNYNBVV02VBG23G2MHCZHAU0QTRUTIR2Q344O14EFEC'
    end

  end
end
