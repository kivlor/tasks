module Tasks
	class Task
		include DataMapper::Resource
		
		property :id,		Serial
		property :title,	String,		:required => true
	end
end