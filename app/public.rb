module Tasks
	class Public < App
		before do
			if admin?
				redirect '/admin'
			end
		end
	
		get '/' do
			erb :'public/index'
		end
		
		get '/signin' do
			erb :'public/signin'
		end
		
		post '/signin' do
			user = User.authenticate(params[:email], params[:password])
			
			if user
				session[:user_id] = user.id
				
				redirect '/admin'
			else
				session[:user_id] = nil
				
				flash[:error] = ['Invalid email/password']
				
				redirect '/signin'
			end
		end
		
		get '/signout' do
			session[:user_id] = nil
			
			redirect '/'
		end
		
		get '/signup' do
			erb :'public/signup'
		end
		
		post '/signup' do
			
			#validate password
			if params[:password].empty? || params[:password2].empty?
				flash[:error] = ['Password/Confirm Password must not be empty']
				
				redirect '/signup'
			elsif params[:password] != params[:password2]
				flash[:error] = ['Password and Confirm Password must match']
				
				redirect '/signup'
			end
			
			user = User.new(:email => params[:email], :password => params[:password])
			
			if user.valid? && user.save
				session[:user_id] = user.id
				
				redirect '/admin'
			else
				flash[:error] = user.errors.values.flatten
				
				redirect '/signup'
			end
		end
		
		get '/error' do
			'an error occured, <a href="/">return home?</a>'
		end
	end
end