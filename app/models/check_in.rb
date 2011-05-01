class CheckIn 
  include Mongoid::Document
  
  field :checkin_id, :type => String
  field :user_id, Type => Integer
  field :reviewed, :type => Boolean, :default => false
end