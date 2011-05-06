class FoodFinder::App < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
    set :views, 'app/views'
    set :public, 'public'
  end

  helpers Helpers

  before do
    save_geolocation if logged?
    save_token
  end

  get '/' do
    haml :'index'
  end

  get '/logout' do
    session[:foodfinder] = nil if logged?
    redirect '/'
  end

  get '/login' do
    redirect Client.client.web_server.
      authorize_url(:redirect_uri => redirect_uri)
  end

  get '/auth/callback' do
    access_token = Client.client.web_server.get_access_token(
      params[:code], :redirect_uri => redirect_uri
    )
    Client.token = access_token.token
    session[:foodfinder] = 
      {:token => Client.token}
    save_token
    session[:foodfinder][:user] = Client.user
    redirect '/'
  end

  
end
