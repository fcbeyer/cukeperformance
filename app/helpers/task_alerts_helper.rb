module TaskAlertsHelper
	
	def display_task_name
		@current_task.display_name
	end
	
	
	def check_all_alerts(task)
		#loop through each alert we have for this task and send accordingly
		alert_list = task.task_alerts.active
		alert_list.each do |current_alert|
			suite_list = Suite.order("runstamp desc").where({:name => task.name, :browser => current_alert.browser}).limit(10)
			average = 0
			suite_list.each do |suite|
				average += suite.duration
			end
			average /= 10
			if average > current_alert.time_limit
				send_alert(task,current_alert,average,suite_list)
			end
		end
	end
	
	def check_alert(alert)
		suite_list = Suite.order("runstamp desc").where({:name => @current_task.name, :browser => alert.browser}).limit(10)
		average = 0
		suite_list.each do |suite|
			average += suite.duration
		end
		average /= 10
		if average > alert.time_limit
			send_alert(@current_task,alert,average,suite_list)
		end
	end
	
	def send_alert(task,current_alert,average,suite_list)
		#oh my god its taking forever!
		RunTimeNotifier.suite_alert(task,current_alert,average,suite_list).deliver
	end
	
	
	def convert_time(time)
		Time.at(time / 1000000000.00).gmtime.strftime('%R:%S:%L')
	end
	
	def dump_suite_list(suite)
		content_tag(:li) do
			link_to suite.name + ' from ' + suite.runstamp.to_s, root_url + suite_path(suite.id)
		end
	end
	
	def get_alert_url
		root_url + test_task_alert_path(@current_task.id)
	end
	
end
