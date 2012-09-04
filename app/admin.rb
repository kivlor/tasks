module Tasks
	class Admin < App
		before do
			private!
			
			@projects = Project.all()
			@current_project = session[:project_id] || current_project(nil)
		end
		
		def current_project(project_id)
			unless project = Project.get(project_id)
				project = Project.first()
			end
			
			@current_project = session[:project_id] = project ? project.id : nil
		end
		
		get '/' do
			@project = Project.get(@current_project)
			
			@open_tasks = @project ? @project.tasks.all(:completed_at => nil) : {}
			@closed_tasks = @project ? @project.tasks.all(:completed_at.not => nil) : {}
			
			erb :'admin/index'
		end
		
		#-----------------------------
		#
		#	Projects
		#
		#-----------------------------
		
		get '/project/switch/:project_id' do
			current_project(params[:project_id])
			
			redirect '/admin'
		end
		
		get '/project/add' do
			erb :'admin/project'
		end
		
		post '/project/add' do
			project = Project.new(:title => params[:title])
			
			if project.valid? && project.save
				current_project(project.id)
				
				flash[:success] = ["Project ##{project.id} has been added"]
				
				redirect '/admin'
			else
				flash[:error] = project.errors.values.flatten
				
				redirect "/admin/project/add"
			end
		end
		
		#-----------------------------
		#
		#	Tasks
		#
		#-----------------------------
		
		post '/task/add' do
			project = Project.get(@current_project)
			
			task = project.tasks.new(:title => params[:title], :description => params[:description])
			
			if task.valid? && task.save
				flash[:success] = ["Task ##{task.id} has been added"]
				
				redirect '/admin'
			else
				flash[:error] = task.errors.values.flatten
				
				redirect "/admin/task/add"
			end
		end
		
		get '/task/view/:task_id' do
			@task = Task.get(params[:task_id])
			@comments = @task.comments.all()
			
			if @task
			   erb :'admin/task/view'
			else
			   flash[:error] = ["Task ##{:task_id} no longer exists"]
			   
			   redirect '/admin'
			end
		end
		
		get '/task/edit/:task_id' do
			@task = Task.get(params[:task_id])
			
			if @task
				erb :'admin/task/form'
			else
				flash[:error] = ["Task ##{:task_id} no longer exists"]
				
				redirect '/admin'
			end
		end
		
		post '/task/edit/:task_id' do
			task = Task.get(params[:task_id])
			
			if task && task.update(:title => params[:title], :description => params[:description], :percent => params[:percent].to_i)
				flash[:success] = ["Task ##{params[:task_id]} has been updated"]
				
				redirect '/admin'
			else
				flash[:error] = task.errors.values.flatten
				
				redirect "/admin/task/edit/#{params[:task_id]}"
			end
		end
		
		get '/task/complete/:task_id' do
			task = Task.get(params[:task_id])
			
			if task && task.update(:completed_at => Time.now.utc)
				flash[:success] = ["Task ##{params[:task_id]} has been completed"]
			else
				flash[:error] = task.errors.values.flatten
			end
			
			redirect '/admin'
		end
		
		get '/task/reopen/:task_id' do
			task = Task.get(params[:task_id])
			
			if task && task.update(:completed_at => nil)
				flash[:success] = ["Task ##{params[:task_id]} has been re-opened"]
			else
				flash[:error] = task.errors.values.flatten
			end
			
			redirect '/admin'
		end
		
		get '/task/delete/:task_id' do
			task = Task.get(params[:task_id])
			
			if task && task.destroy
				flash[:success] = ["Task ##{params[:task_id]} has been deleted"]
			else
				flash[:error] = task.errors.values.flatten
			end
			
			redirect '/admin'
		end
		
		#-----------------------------
		#
		#	Comments
		#
		#-----------------------------
		
		post '/task/comment/:task_id' do
			task = Task.get(params[:task_id])
			comment = task.comments.new(:comment => params[:comment], :user_id => session[:user_id])
			
			if comment.valid? && comment.save
			   flash[:success] = ["Comment added to Task ##{params[:task_id]}"]
			else
			   flash[:error] = comment.errors.values.flatten
			end
			
			redirect "/admin/task/view/#{params[:task_id]}"
		end
	end
end