require File.dirname(__FILE__)+'/models.rb'

module Tasks
	class App < Sinatra::Base
		enable :sessions
		use Rack::Flash
		
		helpers do
			def admin? ; session[:user_id] != nil ; end
			def private! ; redirect '/' unless admin? ; end
		end
		
		#-----------------------------
		#
		#	Uh Oh
		#
		#-----------------------------
		
		not_found do
			erb :'404', :layout => false
		end
		
		error do
			erb :'500', :layout => false
		end
	end
end