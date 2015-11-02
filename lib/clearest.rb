require "clearest/version"
require 'template'
require 'pp'
require 'date'
require 'data_mapper'
require 'dm-is-reflective'
require 'dm-core'
require 'colorize'
require 'dm-sqlite-adapter'




Dir[File.dirname(__FILE__) + '/clearest/patches/*_patch.rb'].sort.each {|file| require file }
Dir[File.dirname(__FILE__) + '/clearest/generators/*.rb'].sort.each {|file| require file }
Dir[File.dirname(__FILE__) + '/clearest/builders/*.rb'].sort.each {|file| require file }
Dir[File.dirname(__FILE__) + '/clearest/validators/*.rb'].sort.each {|file| require file }



