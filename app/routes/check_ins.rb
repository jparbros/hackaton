class FoodFinder < Sinatra::Base
  get '/checkins' do
    haml :'checkins/index'
  end

  get '/checkins/:venue_id' do |venue_id|
    haml :'checkins/show'
  end

  post '/checkins' do
     response = Client.check_in params[:venue_id]
     puts response.inspect
     CheckIn.create :checkin_id => response['checkin']['id']
     redirect '/'
  end
end
