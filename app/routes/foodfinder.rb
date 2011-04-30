class FoodFinder < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
    set :views, 'app/views'
  end

  get '/auth' do
    redirect '/auth/foursquare'
  end

  get '/auth/foursquare/callback' do
    auth_hash = request.env['omniauth.auth']
    auth_hash.inspec
  end

  get '/auth/failure' do
    params.inspect
  end

end
