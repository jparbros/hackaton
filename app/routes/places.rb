class FoodFinder < Sinatra::Base
  get '/places' do
    @places = []
    places_hash = Client.venues_search("#{session[:foodfinder][:latitude]},#{session[:foodfinder][:longitude]}","food",10)
    places_hash['groups'].first['items'].each do |item|
      address = item['location']['address'].to_s + ' ' + 
        item['location']['crossStreet'].to_s
      place = Place.new(:id => item['id'], :name => item['name'], 
            :address => address, 
            :distance => item['location'] && item['location']['distance'],
            :icon => item['categories'] && 
                     item['categories'].first &&
                     item['categories'].first['icon'])
      place.food_review = ReviewFood.where(:venue_id => place.id).count
      place.price_review = ReviewPrice.where(:venue_id => place.id).count
      place.service_review = ReviewService.where(:venue_id => place.id).count
      @places << place
    end
    haml :'places/index'
  end
  
  get '/places/show/:venue_id' do |venue_id|
    response = Client.find_venue(venue_id)
    @place = Place.create response
    haml :'places/show'
  end
end
