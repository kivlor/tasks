require File.dirname(__FILE__)+'/models.rb'

module Tasks

	class App < Sinatra::Base
	
		get '/' do
			@tasks = Task.all()
		
			erb :'home/index'
		end
		
		post '/' do
			
			@task = Task.new(:title => params[:title], :created => Time.now)
			
			if @task.save
				redirect '/'
			else
				reditect '/error'
			end
		end
		
		get '/error' do
			'an error occured'
		end
		
	end
	
end