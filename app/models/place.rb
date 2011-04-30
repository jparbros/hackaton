class Place
  attr_accessor :id, :name, :address, :distance, :icon, :food_review, :service_review, :price_review
  
  def initialize(attrs={})
    attrs.each do |k,v|
      self.send("#{k}=",v)
    end
  end
end