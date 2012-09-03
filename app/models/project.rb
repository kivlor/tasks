module Tasks
	class Project
		include DataMapper::Resource
		
		property :id,					Serial
		property :title,				String,			:required => true
		property :created_at,			DateTime
		property :updated_at,			DateTime
		
		has n, :tasks
	end
end