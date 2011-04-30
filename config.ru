require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'
require './lib/setup'

ENV['RACK_ENV'] ||= 'development'

Setup.start

use Rack::Session::Cookie
run FoodFinder::Home
