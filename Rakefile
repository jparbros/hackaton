require 'rubygems'
require 'rake/testtask'
require 'bundler'

task :default => :test

desc "Console"
task :console do
  ENV['RACK_ENV'] ||= 'development'
  exec "irb -r ./lib/setup"
end