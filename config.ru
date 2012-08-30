require	'bundler/setup'
Bundler.require(:default)

require File.dirname(__FILE__)+'/app/app.rb'
require File.dirname(__FILE__)+'/app/public.rb'
require File.dirname(__FILE__)+'/app/admin.rb'

map '/' do
	run Tasks::Public
end

map '/admin' do
	run Tasks::Admin
end