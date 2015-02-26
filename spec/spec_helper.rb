require 'rack/test'
require 'rspec'

require File.expand_path '../../sqlmusic.rb', __FILE__ #getting the server

module RSpecMixin
	include Rack::Test::Methods
	def app() Sinatra::Application end 
end
#this is basically setting up collections of methods we can use.

RSpec.configure { |c| c.include RSpecMixin }
#this is configuring it to include the methods.

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end