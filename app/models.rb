DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/tasks.db")

#require File.dirname(__FILE__)+'/models/task.rb'
#require File.dirname(__FILE__)+'/models/user.rb'

# load all teh models, sexy!
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

DataMapper.finalize.auto_upgrade!