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
			
			@open_tasks = @project ? @project.tasks.all(:completed => nil) : {}
			@closed_tasks = @project ? @project.tasks.all(:completed.not => nil) : {}
			
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
			project = Project.create(:title => params[:title], :created => Time.now)
			
			if project.save
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
			
			project.tasks.create(:title => params[:title], :created => Time.now)
			
			if project.tasks.save
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
			params.inspect
		end
		
		get '/task/close/:task_id' do
		end
	end
end