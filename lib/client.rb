module Client
  extend self

  AUTH_URL = 'https://foursquare.com/oauth2'
  API_URL =  "https://api.foursquare.com/v2"
  CLIENT_ID = 'M3Z2OBWQB4RPYNY22S112I4DVI5W4VQB5LRDJRPGEK1LK5RO'
  SECRET = '53BWA4J3YLU4ZEM2NNNAHFQMG0AOAZ3GRO25UBRD5OFAWGLC'

  def authenticate(redirect_uri)
    "#{AUTH_URL}/authenticate?client_id=#{CLIENT_ID}&response_type=code&redirect_uri=#{redirect_uri}"
  end

  def access_token(redirect_uri, code)
    response = RestClient.get "#{AUTH_URL}/access_token?client_id=#{CLIENT_ID}" +
      "&client_secret=#{SECRET}" +
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
    response = RestClient.get "#{API_URL}/venues/search?oauth_token=#{token}&ll=#{ll}&query=#{query}&limit=#{limit}"
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
