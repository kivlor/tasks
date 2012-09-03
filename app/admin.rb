module Tasks
	class Admin < App
		
		before do
			private!
			
			@projects = Project.all()
			@current_project = session[:current_project] || current_project(nil)
		end
		
		def current_project(project_id)
			unless project = Project.get(project_id)
				project = Project.first()
			end
			
			@current_project = session[:current_project] = project ? project.id : nil
		end
		
		get '/' do
			@project = Project.get(@current_project)
			
			@open_tasks = @project ? @project.tasks.all(:completed_at => nil) : {}
			@closed_tasks = @project ? @project.tasks.all(:completed_at.not => nil) : {}
			
			erb :'admin/index'
		end
		
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
				
				redirect '/admin'
			else
				redirect '/error'
			end
		end
		
		get '/task/add' do
			erb :'admin/task'
		end
		
		post '/task/add' do
			project = Project.get(@current_project)
			
			project.tasks.new(:title => params[:title])
			
			if project.tasks.valid? && project.tasks.save
				redirect '/admin'
			else
				redirect '/error'
			end
		end
		
		get '/task/edit/:task_id' do
			@task = Task.get(params[:task_id])
			
			if @task
				erb :'admin/task'	
			else
				redirect '/error'
			end
		end
		
		post '/task/edit/:task_id' do
			task = Task.get(params[:task_id])
			
			if task && task.update(:title => params[:title], :percent => params[:percent].to_i)
				redirect '/admin'
			else
				redirect '/error'
			end
		end
		
		get '/task/complete/:task_id' do
			task = Task.get(params[:task_id])
			
			if task && task.update(:completed_at => Time.now.utc)
				redirect '/admin'
			else
				redirect '/error'
			end
		end
	end
end