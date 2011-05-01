class FoodFinder < Sinatra::Base
  get '/checkins' do
    haml :'checkins/index'
  end

  get '/checkins/:venue_id' do |venue_id|
    haml :'checkins/show'
  end
end
