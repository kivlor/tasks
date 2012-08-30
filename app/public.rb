module Tasks

	class Public < App
		
		#home!
		get '/' do
			if admin?
			   redirect '/admin'
			end
			
			erb :'public/index'
		end
		
		# user sign in/up
		get '/signin' do
			if admin?
				redirect '/admin'
			end
		
			erb :'public/signin'
		end
		
		post '/signin' do
			user = User.authenticate(params[:email], params[:password])
			
			if user
			   session[:user] = user
			   
			   redirect '/admin'
			else
			   session[:user] = nil
			   
			   redirect '/error'
			end
		
		end
		
		get '/signout' do
			session[:user] = nil
			redirect '/'
		end
		
		get '/signup' do
			erb :'public/signup'
		end
		
		post '/signup' do
			
			#validate password
			if params[:password].empty? || params[:password2].empty?
				redirect '/error'
			elsif params[:password] != params[:password2]
				redirect '/error'
			end
			
			@user = User.new(:email => params[:email], :password => params[:password], :created => Time.now)
			
			if @user.save
				session[:user] = @user
				redirect '/admin'
			else
				redirect '/error'
			end
		end
				
		#errors!
		get '/error' do
			'an error occured, <a href="/">return home?</a>'
		end
	end
end