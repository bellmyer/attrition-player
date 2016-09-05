require 'sinatra'
require 'json'

require './lib/player'

set :port, 6001
set :bind, `ifconfig`.scan(/192\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/).first

before do
  content_type :json
end

configure do 
  set :player, Player.new
end

get '/ping' do
  {status: 'success', name: settings.player.name}.to_json
end

post '/move' do
  {status: 'success', soldiers: settings.player.move(params[:armies].to_i, params[:soldiers].to_i)}.to_json
end