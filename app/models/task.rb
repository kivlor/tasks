module Tasks
	class Task
		include DataMapper::Resource
		
		property :id,			Serial
		property :title,		String,			:required => true
		property :percent,		Integer,		:default => 0
		
		property :created,		DateTime
		property :completed,	DateTime
		
		belongs_to :project
	end
end