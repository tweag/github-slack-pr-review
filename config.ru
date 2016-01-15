$:.unshift File.expand_path('../lib', __FILE__)
require 'rubygems'
require 'bundler'
Bundler.require :default

require './app'
run App
