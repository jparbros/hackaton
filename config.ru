require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'

ENV['RACK_ENV'] ||= 'development'
require './lib/setup'

use Rack::Session::Cookie
run FoodFinder
