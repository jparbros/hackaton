class FoodFinder < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
    set :views, 'app/views'
    set :public, 'public'
  end

  before do
    save_geolocation if logged?
  end

  get '/' do
    haml :'index'
  end

  get '/logout' do
    session[:foodfinder] = nil if logged?
    redirect '/'
  end

  get '/login' do
    redirect '/' if logged?
    redirect client.authorize_url
  end

  get '/auth/callback' do
    session[:foodfinder] = {:token => client.access_token(params[:code])}
    foursquare = ::Foursquare2::Base.new(client)
    puts foursquare.venues_categories
    redirect '/'
  end

  private
  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/auth/callback'
    uri.query = nil
    uri.to_s
  end

  def client
    @client ||= ::Foursquare2::OAuth2.new('M3Z2OBWQB4RPYNY22S112I4DVI5W4VQB5LRDJRPGEK1LK5RO', '53BWA4J3YLU4ZEM2NNNAHFQMG0AOAZ3GRO25UBRD5OFAWGLC', redirect_uri)
  end

  def logged?
    !!session[:foodfinder]
  end

  def save_geolocation
    session[:foodfinder] ||= {}
    session[:foodfinder][:latitude] = request.cookies['foodfinder-lat']
    session[:foodfinder][:longitude] = request.cookies['foodfinder-lon']
  end

end
