class FoodFinder < Sinatra::Base
  get '/checkins' do
    haml :'checkins/index'
  end

  get '/checkins/:venue_id/new' do |venue_id|
    response = Client.find_venue(venue_id)
    @place = Place.create response['venue']
    haml :'checkins/new'
  end

  post '/checkins/:venue_id' do
     response = Client.check_in params[:venue_id]
     CheckIn.create :checkin_id => response['checkin']['id'], 
                    :user_id => session[:foodfinder]['user']['response']['user']['id']
     redirect '/'
  end
end
