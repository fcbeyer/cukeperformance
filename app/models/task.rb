class Task < ActiveRecord::Base
	has_many :task_alerts, :dependent => :destroy	
	
end
