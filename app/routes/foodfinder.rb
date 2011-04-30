class FoodFinder < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
  end

  get '/' do
    puts "here"
  end
end
