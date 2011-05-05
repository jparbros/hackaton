class FoodFinder::App < Sinatra::Base
  get '/places' do
    @places = []
    places_hash = Client.venues_search("#{session[:foodfinder][:latitude]},#{session[:foodfinder][:longitude]}","food restaurant",10)
    places_hash['groups'].first['items'].each { |item| @places << Place.create(item) }
    @places.sort! {|x,y| x.review_avg <=> y.review_avg }
    haml :'places/index'
  end
  
  get '/places/show/:venue_id' do |venue_id|
    response = Client.find_venue(venue_id)
    @place = Place.create response['venue']
    haml :'places/show'
  end
end
