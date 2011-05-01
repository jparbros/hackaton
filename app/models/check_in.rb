class CheckIn 
  include Mongoid::Document
  
  field :checkin_id, :type => String
  field :reviewed, :type => Boolean, :default => false
end