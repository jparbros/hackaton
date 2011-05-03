class Place
  attr_accessor :id, :name, :address, :distance, :icon, :food_review, :service_review, :price_review

  class << self

    def create(attrs = {})
      address = attrs['venue']['location']['address'].to_s + ' ' + attrs['venue']['location']['crossStreet'].to_s
      self.new(:id => attrs['venue']['id'], :name => attrs['venue']['name'], :address => address, :distance => attrs['venue']['location']['distance'] , :icon => attrs['venue']['categories'].first['icon'])
    end
  end

  def initialize(attrs={})
    attrs.each do |k,v|
      self.send("#{k}=",v)
    end
  end

  def food_review
    unless @food_review
      food_sum = 0
      food_reviews = ReviewFood.where(:venue_id => self.id)
      @food_review = if food_reviews.size > 0
            food_reviews.each {|review| food_sum += review.rating}
            (food_sum/food_reviews.size)
        else 
            0
        end
    else
      @food_review
    end
  end

  def price_review
    unless @price_review
      price_sum = 0
      price_reviews = ReviewPrice.where(:venue_id => self.id)
      @price_review = if price_reviews.size > 0
            price_reviews.each {|review| price_sum += review.rating}
            (price_sum/price_reviews.size)
        else 
            0
        end
    else
      @price_review
    end
  end
  
  def service_review
    unless @service_review
      service_sum = 0
      service_reviews = ReviewService.where(:venue_id => self.id)
      @service_review = if service_reviews.size > 0
            service_reviews.each {|review| service_sum += review.rating}
            (service_sum/service_reviews.size)
        else 
            0
        end
    else
      @service_review
    end
  end
  
  def review_avg
    (food_review+price_review+service_review)/3
  end
  
end