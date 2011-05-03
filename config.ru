require 'rubygems'
require 'bundler/setup'

require 'sinatra/base'

ENV['RACK_ENV'] ||= 'development'
require './lib/setup'

run FoodFinder
