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

    @token = JSON.parse(response)['access_token']
    @token
  end

  def user
    response = RestClient.get "#{API_URL}/users/self?oauth_token=#{@token}"
    JSON.parse(response)
  end

end
