module Tasks
	class User
	
		include DataMapper::Resource
		
		attr_accessor :password
		
		before :create do |user|
			user.encrypt_password
		end
		
		property :id,					Serial
		property :email,				String,			:required => true,		:unique => true
		property :password_salt,		String,			:length => 0..255
		property :password_hash,		String,			:length => 0..255
		
		property :created,				DateTime
		
		validates_with_method :validate_password
		
		def validate_password
			if self.saved?
				true
			else
				if password.nil?
					false
				elsif password.length < 8
					false
				else
					true
				end
			end
		end
		
		def encrypt_password
			if password.nil?
				false
			else
				self.password_salt = BCrypt::Engine.generate_salt
				self.password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
			end	
		end
		
		def self.authenticate(email, password)
			user = User.first(:email => email)
			
			if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
				user
			else
				nil
			end
		end
		
	end
end