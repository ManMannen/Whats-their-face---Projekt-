require 'slim'
require 'sinatra'
require 'BCrypt'
require_relative 'app.rb'
enable :sessions

get '/' do
    slim :index
end

post 'search' do
    search = params['search']
end

get 'results/:search' do
    slim :results
end