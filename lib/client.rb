module Client
  extend self

  def authenticate(redirect_uri)
    "#{FoodFinder::Config.auth_url}/authenticate?client_id=#{FoodFinder::Config.client_id}&response_type=code&redirect_uri=#{redirect_uri}"
  end

  def access_token(redirect_uri, code)
    response = RestClient.get "#{FoodFinder::Config.auth_url}/access_token?client_id=#{FoodFinder::Config.client_id}" +
      "&client_secret=#{FoodFinder::Config.secret}" +
      "&grant_type=authorization_code" +
      "&redirect_uri=#{redirect_uri}" +
      "&code=#{code}"

    token= JSON.parse(response)['access_token']
    token
  end
  
  def token
    @token
  end
  
  def token=(token_)
    @token = token_
  end
  
  def venues_search(ll,query,limit)
    response = RestClient.get "#{FoodFinder::Config.api_url}/venues/search?oauth_token=#{token}&ll=#{ll}&query=#{query}&limit=#{limit}"
    JSON.parse(response)['response']
  end
  
  def find_venue(venue_id)
    response = RestClient.get "#{FoodFinder::Config.api_url}/venues/#{venue_id}?oauth_token=#{token}"
    JSON.parse(response)['response']
  end
  
  def check_in(venue_id)
    response = RestClient.post "#{FoodFinder::Config.api_url}/checkins/add?oauth_token=#{token}", :venueId => venue_id, :broadcast => 'public,facebook,twitter'
    JSON.parse(response)['response']
  end

  def user
    puts ">>>>>>>> #{self.token}"
    response = RestClient.get "#{FoodFinder::Config.api_url}/users/self?oauth_token=#{token}"
    JSON.parse(response)
  end

end
