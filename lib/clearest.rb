require "./clearest/version"
require './template'
require 'pp'
require 'date'
require 'data_mapper'
require 'dm-is-reflective'
require 'dm-core'
require 'colorize'
require 'dm-sqlite-adapter'




Dir[File.dirname(__FILE__) + '/patches/*_patch.rb'].sort.each {|file| p file ;require file }
Dir[File.dirname(__FILE__) + '/generators/*.rb'].sort.each {|file| p file ;require file }
Dir[File.dirname(__FILE__) + '/builders/*.rb'].sort.each {|file| p file;require file }



