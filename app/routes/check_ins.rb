class FoodFinder < Sinatra::Base
  post '/checkins' do
     response = Client.check_in params[:venue_id]
     puts response.inspect
     CheckIn.create :checkin_id => response['checkin']['id']
     redirect '/'
  end
end