require File.expand_path '../spec_helper.rb', __FILE__

describe "My voting app for Spotify" do 

	describe "get '/songs'" do
		it "should allow access to the hompage" do
			get '/songs'
			expect(last_response).to be_ok
		end
		it "should load the home page" do
			get '/songs'
			page.should have_content("votify")
			#I know I am missing a piece here but not sure what.
			#just trying to test for a string
		end
		it "should have a playlist" do
			expect(Playlist.all).to_not eq nil
		end
		it "should be creating a new artist" do
			playlist = Playlist.create(artist:artist, track:track)
			playlist.artist.new("Sia")
			expect(playlist.artist).to have_attributes(artist:"Sia")
		end
	end
	describe "get 'songs/play" do
		it "should order votes by DESC" do
		  expect(Playlist.all.order()).to be :DESC
		  #order needs arguments.
	    end
	end
	describe "POST '/songs'" do
		it "check that the redirect is working." do
			post '/songs'
			follow_redirect!
			last_request.path.should == '/songs'
		end
	end
	describe "put '/songs/:id/up'" do
		it "should add a vote to a song when the button is pressed" do
		    put '/songs/:id/up'
		    playlist = Playlist.find(params[:id])
		    expect(playlist.votes).to eq +1	
		end
	end
	describe "'/songs/:id'" do
		it "should delete a song" do
	        playlist = Playlist.find(params[:id])
	        playlist.delete
	        expect(playlist.all).to eq nil
	        #there's something with :destroy delete that I am confused about.
	    end
	end
end

#the first thing to test for is your status codes. So you can do that do that for each.
#is your html being served up?
#maybe test for a specific string being returned?
#are your links working?
#is something being added correctly?
#is it redirecting?
#test the responce, is it not nil? Is it coming back in the right format?
#away to check that you are serving the html is testing for a string which is always there like Votify.
#don't forget about escaping quotations.
#you can test for specific html or css - by putting it in as a string.
#go through each route, what do you expect it do, is it doing that.
#you can send params. like the param should be equal to bla bla bla