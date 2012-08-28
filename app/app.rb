require File.dirname(__FILE__)+'/models.rb'

module Tasks

	class App < Sinatra::Base
	
		get '/' do
			@tasks = Task.all()
		
			erb :'home/index'
		end
		
		post '/' do
			params[:title]
		end
		
	end
	
end