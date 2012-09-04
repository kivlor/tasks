module Tasks
	class Comment
		include DataMapper::Resource
		
		property :id,					Serial
		property :comment,				Text,			:required => true,			:lazy => false
		property :created_at,			DateTime
		property :updated_at,			DateTime
		
		belongs_to :task
		belongs_to :user
	end
end