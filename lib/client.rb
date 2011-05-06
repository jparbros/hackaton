module Client
  extend self

  API_URL = "https://api.foursquare.com/v2"

  def client
    OAuth2::Client.new(FoodFinder::Config.client_id, 
      FoodFinder::Config.secret, 
      :site => 'https://foursquare.com',
      :authorize_url => '/oauth2/authenticate',
      :access_token_url => '/oauth2/access_token')
  end

  def token
    @token
  end
  
  def token=(token_)
    @token = token_
  end
  
  def venues_search(ll,query,limit)
    response = RestClient.get "#{API_URL}/venues/search?oauth_token=#{token}&ll=#{ll}&query=#{CGI.escape(query)}&limit=#{limit}"
    JSON.parse(response)['response']
  end
  
  def find_venue(venue_id)
    response = RestClient.get "#{API_URL}/venues/#{venue_id}?oauth_token=#{token}"
    JSON.parse(response)['response']
  end
  
  def check_in(venue_id)
    response = RestClient.post "#{API_URL}/checkins/add?oauth_token=#{token}", :venueId => venue_id, :broadcast => 'public,facebook,twitter'
    JSON.parse(response)['response']
  end

  def user
    puts ">>>>>>>> #{self.token}"
    response = RestClient.get "#{API_URL}/users/self?oauth_token=#{token}"
    JSON.parse(response)
  end

end
