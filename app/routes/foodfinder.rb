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
    redirect client.authorize_url
  end

  get '/auth/callback' do
    puts params.inspect
    session[:foodfinder] = {:token => client.access_token(params[:code])}
    puts session[:foodfinder].inspect
    redirect '/'
  end
end
