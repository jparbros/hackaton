require 'rubygems'
require 'bundler'

desc "Console"
task :console do
  ENV['RACK_ENV'] ||= 'development'
  exec "irb -r ./lib/setup"
end
