module Tasks
	class Admin < App
	
		get '/' do
			private!
			
			erb :'admin/index'
		end
	end
end