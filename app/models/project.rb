module Tasks
	class Project
		include DataMapper::Resource
		
		property :id,			Serial
		property :title,		String,			:required => true
		property :created,		DateTime
		
		has n,					:tasks
	end
end