module Tasks
	class Task
		include DataMapper::Resource
		
		property :id,					Serial
		property :title,				String,			:required => true
		property :description,			Text
		property :percent,				Integer,		:default => 0
		
		property :completed_at,			DateTime
		property :created_at,			DateTime
		property :updated_at,			DateTime
		
		belongs_to :project
		has n, :comments
		
		validates_numericality_of :percent,	:gte => 0, :lte => 100
	end
end