class FoodFinder < Sinatra::Base
  get '/places' do
    @places = []
    places_hash = Client.venues_search("#{session[:foodfinder][:latitude]},#{session[:foodfinder][:longitude]}","food",10)
    places_hash['groups'].first['items'].each do |item|
      address = item['location']['address'].to_s + ' ' + item['location']['crossStreet'].to_s
      place = Place.new({:id => item['id'], :name => item['name'], :address => address, :distance => item['location']['distance'] , :icon => item['categories'].first['icon']})
      place.food_review = ReviewFood.where(:venue_id => place.id).count
      place.price_review = ReviewPrice.where(:venue_id => place.id).count
      place.service_review = ReviewService.where(:venue_id => place.id).count
      @places << place
    end
    haml :'places/index'
  end
  
  get '/places/show/:venue_id' do |venue_id|
    place_hash = Client.find_venue(venue_id)
    address = place_hash['venue']['location']['address'].to_s + ' ' + place_hash['venue']['location']['crossStreet'].to_s
    @place = Place.new({:id => place_hash['venue']['id'], :name => place_hash['venue']['name'], :address => address, :distance => place_hash['venue']['location']['distance'] , :icon => place_hash['venue']['categories'].first['icon']})
    food_sum = 0
    ReviewFood.where(:venue_id => @place.id).each {|review| food_sum += review.rating}
    @place.food_review = (ReviewFood.where(:venue_id => @place.id).count > 0)? food_sum/ReviewFood.where(:venue_id => @place.id).count : 0
    service_sum = 0
    ReviewService.where(:venue_id => @place.id).each {|review| service_sum += review.rating}
    @place.service_review = (ReviewService.where(:venue_id => @place.id).count > 0)? service_sum/ReviewService.where(:venue_id => @place.id).count : 0
    price_sum = 0
    ReviewPrice.where(:venue_id => @place.id).each {|review| price_sum += review.rating}
    @place.service_review = (ReviewPrice.where(:venue_id => @place.id).count > 0)? price_sum / ReviewPrice.where(:venue_id => @place.id).count : 0
    haml :'places/show'
  end
end