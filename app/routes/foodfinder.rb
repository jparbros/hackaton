class FoodFinder < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
    set :views, 'app/views'
    set :public, 'public'
  end

  get '/' do
    haml :'index'
  end

  delete '/' do
    session[:oauth].delete
  end

  get '/auth' do
    redirect client.request_token.authorize_url unless[:oauth]
  end

  get '/auth/callback' do
    token, verifier = params['oauth_token'], params['oauth_verifier']
  end

  private
  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/auth/callback'
    uri.query = nil
    uri.to_s
  end

  def client
    oauth = Foursquare::OAuth.new('M3Z2OBWQB4RPYNY22S112I4DVI5W4VQB5LRDJRPGEK1LK5RO', '53BWA4J3YLU4ZEM2NNNAHFQMG0AOAZ3GRO25UBRD5OFAWGLC')
    oauth.set_callback_url redirect_uri
    oauth
  end

end
