module Tasks
	class Task
		include DataMapper::Resource
		
		property :id,			Serial
		property :title,		String,			:required => true
		
		property :created,		DateTime
		property :completed,	DateTime
	end
end