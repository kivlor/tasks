DataMapper.setup(:default, "postgres://localhost/tasks")

require File.dirname(__FILE__)+'/models/task.rb'

DataMapper.finalize.auto_upgrade!