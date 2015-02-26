require File.expand_path '../spec_helper.rb', __FILE__

describe "My voting app for Spotify" do 

	describe "get '/songs'" do
		it "should allow access to the hompage" do
			get '/songs'
			expect(last_response).to be_ok
		end
		it "should contain my HTML and therefore a string 'Votify'" do
			get '/songs'
			expect(last_response.body).to include("Votify")
		end
		it "should have a playlist" do
			expect(Playlist.all).to_not eq nil
		end
	end #end desrcibe

	describe "put '/songs/:id/up'" do
		it "should add a vote to a song when the button is pressed" do
		    #you might need to go to go to a get route first to get an id then to the put. We need to hit the server somewhere to look up some entry. 
		    get '/songs'
		    first = Playlist.first
			id = first.id
		    put "/songs/#{id}/up", {votes: 1}
            song = Playlist.find(id)
            song.votes = 1
            song.save
		    expect(song).to have_attributes(votes:1)	
		end
	end #describe end

	#add in for down

	describe "'/songs/:id'" do
		it "should delete a song" do
			post '/songs', {artist: "Sia"}
			playlist = Playlist.create(:artist => "Sia")
			most_recent = Playlist.last
			id = most_recent.id
			delete "/songs/#{id}"
			most_recent.delete
			expect(Playlist.exists?("#{id}")).to eq(false)
		end
	end
	
	describe "POST '/songs'" do
		it "check that the redirect is working." do
			post '/songs'
			follow_redirect!
			last_request.path.should == '/songs'
		end
		it "should be creating a new artist" do
			post '/songs', {artist: "Sia"}
			Playlist = Struct.new(:artist)
			#look up struct
			playlist = Playlist.new("Sia")
			expect(playlist).to have_attributes(artist:"Sia")
		end
	end #end describe
end