class Review
  include Mongoid::Document
  
  field :type, :type => String
  field :rating, :type => Integer, :default => 0
  field :venue_id, :type => Integer
end