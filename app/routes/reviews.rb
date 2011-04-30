class FoodFinder < Sinatra::Base
  get '/reviews/new' do
    haml :'reviews/new'
  end
  
  post '/reviews/create' do
    params['review'].each do |review|
      case review['type']
        when 'food'
          ReviewFood.create review
        when 'price'
          ReviewPrice.create review
        when 'service'
          ReviewService.create review
      end
    end
  end
end
