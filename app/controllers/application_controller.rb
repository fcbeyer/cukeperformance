class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_suite_list
	
	def get_suite_list
		@suite_list = Task.where(active: true)
	end
end
