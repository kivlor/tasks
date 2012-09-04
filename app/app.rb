require File.dirname(__FILE__)+'/models.rb'

module Tasks
	class App < Sinatra::Base
		enable :sessions
		use Rack::Flash
		
		helpers do
			def admin? ; session[:user_id] != nil ; end
			def private! ; redirect '/' unless admin? ; end
		end
	end
end