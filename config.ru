require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'
require './lib/setup'

ENV['RACK_ENV'] ||= 'development'

Setup.start

use Rack::Session::Cookie
use OmniAuth::Strategies::Foursquare, 'M3Z2OBWQB4RPYNY22S112I4DVI5W4VQB5LRDJRPGEK1LK5RO', '53BWA4J3YLU4ZEM2NNNAHFQMG0AOAZ3GRO25UBRD5OFAWGLC'
run FoodFinder
