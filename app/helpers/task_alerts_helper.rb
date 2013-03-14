module TaskAlertsHelper
	
	def display_task_name
		@current_task.display_name
	end
	
	
	def check_average(task)
		#loop through each alert we have for this task and send accordingly
		# alert_list = task.task_alerts
		# alert_list.each do |current_alert|
			# suite_list = Suite.order("id desc").where({:name => task.name, :browser => current_alert.browser}).limit(10)
			# average = 0
			# suite_list.each do |suite|
				# average += suite.duration
			# end
			# average /= 10
			# if average > current_alert.time_limit
				# send_alert(task)
			# end
		# end
		send_alert(task)
	end
	
	def send_alert(task)
		#oh my god its taking forever!
		if task.name.eql?("BVT")
			RunTimeNotifier.bvt.deliver
		end
	end
	
end
