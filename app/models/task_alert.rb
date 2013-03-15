class TaskAlert < ActiveRecord::Base
	belongs_to :task
	
	scope :active, where(:active => true)
	
	
end
