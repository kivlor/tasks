require File.dirname(__FILE__)+'/models.rb'

module Tasks
	class App < Sinatra::Base
		enable :sessions
		
		helpers do
			def admin? ; session[:user] != nil ; end
			def private! ; redirect '/' unless admin? ; end
		end
	end
end