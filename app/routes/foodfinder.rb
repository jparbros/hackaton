class FoodFinder < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
  end

  def client
    oauth = Foursquare::OAuth.new('M3Z2OBWQB4RPYNY22S112I4DVI5W4VQB5LRDJRPGEK1LK5RO', '53BWA4J3YLU4ZEM2NNNAHFQMG0AOAZ3GRO25UBRD5OFAWGLC')
    oauth.set_callback_url redirect_uri
    oauth
  end

  get '/auth' do
    redirect client.request_token.authorize_url
  end

  get '/auth/callback' do
    token, verifier = params['oauth_token'], params['oauth_verifier']
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/auth/callback'
    uri.query = nil
    uri.to_s
  end

end
