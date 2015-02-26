require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection({
	:adapter =>'sqlite3', 
	:database =>'playlist'
	})
ActiveRecord::Base.logger = Logger.new(STDOUT)