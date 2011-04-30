class FoodFinder < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
    set :views, 'app/views'
  end

  get '/' do
    puts "here"
    haml :index
  end
end
