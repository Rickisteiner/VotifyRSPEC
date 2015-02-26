require 'sinatra'
require 'sqlite3'
require 'httparty'
require "awesome_print"
require 'pry'
require 'unicorn'
require_relative 'lib/playlist'
require_relative 'lib/connection'

db = SQLite3::Database.new "playlist" #connecting to the database.

after do
  ActiveRecord::Base.connection.close
end

get '/songs' do
  playlist = Playlist.all.order(votes: :desc) #showing the playlist and ordering it by votes.
  # puts playlist.ai
  erb :index, locals: {playlist: playlist} #playlist is our table name.
end

get '/songs/play' do
  playlist = Playlist.all.order(votes: :desc)
  # puts playlist.ai
  list_of_IDs = Playlist.select(:track_ID,:votes).order(votes: :desc)
  final_URL = "https://embed.spotify.com/?uri=spotify:trackset:VOTEFY:"
  array = []
  list_of_IDs.each do |id|
    if id.votes > 0
      track = id.track_ID
      array.push(track)
    end
  end
  array.each do |song|
    formatted = song + ","
    final_URL = final_URL + formatted
  end
  erb :show, locals: {playlist: playlist, final_URL: final_URL}
end

post '/songs' do
  response = HTTParty.get("https://api.spotify.com/v1/search", :query => {:q => "artist:\"#{params['artist']}\" track:\"#{params['track']}\"",:type => 'track'})
  #the / is getting us out of quotes.
  #this is making the API call and getting that info.
  if response["tracks"]["total"] != 0
    path = response["tracks"]["items"][0]
    artist = path["artists"][0]["name"]
    track = path["name"]
    track_ID = path["id"] #this is is adding what we want into the db.
    image = path["album"]["images"][1]["url"]
    Playlist.create(artist:artist, track:track, track_ID:track_ID, image:image)
    redirect '/songs'
  else
    redirect '/songs'
  end
end

put '/songs/:id/up' do #voting up
  playlist = Playlist.find(params[:id])
  current_votes = playlist.votes
  playlist.votes = current_votes+1
  playlist.save
  redirect '/songs'
end

put '/songs/:id/down' do #voting down
  playlist = Playlist.find(params[:id])
  current_votes = playlist.votes
  playlist.votes = current_votes-1
  playlist.save
  redirect '/songs'
end

delete '/songs/:id' do
  playlist = Playlist.find(params[:id])
  playlist.delete
  redirect '/songs'
 end
