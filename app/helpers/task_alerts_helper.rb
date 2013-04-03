module TaskAlertsHelper
	
	def display_task_name
		@current_task.display_name
	end
	
	def hours_display
    content_tag(:div, :class => "field") do
      number_field_tag('hours', @task_alert_time_converted[0], :in => 0...13)
    end
  end
  
  def minutes_display
    content_tag(:div, :class => "field") do
      number_field_tag('minutes', @task_alert_time_converted[1], :in => 0...60)
    end
  end
  
  def seconds_display
    content_tag(:div, :class => "field") do
      number_field_tag('seconds', @task_alert_time_converted[2], :in => 0...60)
    end
  end
  
  def milliseconds_display
    content_tag(:div, :class => "field") do
      number_field_tag('milliseconds', @task_alert_time_converted[3], :in => 0...1000)
    end
  end
	
	
	def check_task_alerts(task,send_email)
		#loop through each alert we have for this task and send accordingly
		alert_list = task.task_alerts.active
		alerts_triggered = []
		alert_list.each do |current_alert|
			suite_list = Suite.order("runstamp desc").where({:name => task.name, :browser => current_alert.browser}).limit(10)
			average = 0
			suite_list.each do |suite|
				average += suite.duration
			end
			average /= 10
			if average > current_alert.time_limit
				send_alert(task,current_alert,average,suite_list) unless send_email.to_s.eql?("false")
				alerts_triggered.push([current_alert,true,convert_time(average)])
			else
				alerts_triggered.push([current_alert,false,convert_time(average)])
			end
		end
		return alerts_triggered
	end
	
	def check_alert(alert,send_email)
		suite_list = Suite.order("runstamp desc").where({:name => @current_task.name, :browser => alert.browser}).limit(10)
		average = 0
		suite_list.each do |suite|
			average += suite.duration
		end
		average /= 10
		if average > alert.time_limit
			send_alert(@current_task,alert,average,suite_list) unless send_email.to_s.eql?("false")
			return [alert,true,convert_time(average)]
		end
		return [alert,false,convert_time(average)]
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
	
	def build_duration_value(hours, minutes, seconds, milliseconds)
		hours = hours.to_i * 3600000000000
		minutes = minutes.to_i * 60000000000
		seconds = seconds.to_i * 1000000000
		milliseconds = milliseconds.to_i * 1000000
		return hours + minutes + seconds + milliseconds
		
	end
	
end
