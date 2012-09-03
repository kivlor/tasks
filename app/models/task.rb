module Tasks
	class Task
		include DataMapper::Resource
		
		property :id,					Serial
		property :title,				String,			:required => true
		property :percent,				Integer,		:default => 0
		property :completed_at,			DateTime
		
		property :created_at,			DateTime
		property :updated_at,			DateTime
		
		belongs_to :project
	end
end