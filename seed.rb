require 'active_record'
require 'SQLite3'
require_relative 'lib/playlist'
require_relative 'lib/connection'


Playlist.create({
  artist: "Nate Ruess",
  track: "Nothing Without Love"
});

Playlist.create({
  artist: "Hozier",
  track: "Take Me To Church"
});

Playlist.create({
  artist: "Sam Smith",
  track: "Good Thing"
});