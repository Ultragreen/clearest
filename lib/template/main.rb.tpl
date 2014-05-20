# encoding: UTF-8
require 'json'
require 'sinatra'
require 'data_mapper'
require 'dm-migrations'


config = {
  :development => {
    :debug => true, 
    :dsn => '%%DSN%%'
  },
  :test => {
    :debug => false, 
     :dsn => '%%DSN%%'
  },
  :production => {
    :debug => false, 
    :dsn => '%%DSN%%'
  }
}

config.each do |env,params|
  
  configure env do
    DataMapper::Logger.new($stdout, :debug) if params[:debug]
    DataMapper.setup( :default, params[:dsn])
  end
end

require './models/init'
require './helpers/init'
require './routes/init'

DataMapper.finalize
