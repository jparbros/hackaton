class FoodFinder < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
    set :views, 'app/views'
    set :public, 'public'
  end

  helpers Helpers

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
    redirect Client.authenticate redirect_uri
  end

  get '/auth/callback' do
    session[:foodfinder] = 
      {:token => Client.access_token(redirect_uri, params['code'])}
    session[:foodfinder][:user] = Client.user
    redirect '/'
  end
end
