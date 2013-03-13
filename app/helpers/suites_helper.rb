module SuitesHelper
	def check_average(task)
		#hard coded alert levels for now, will change in future
		suite_list = Suite.order("id desc").where({:name => task.name, :browser => ""}).limit(10)
		average = 0
		suite_list.each do |suite|
			average += suite.duration
		end
		average /= 10
		if average > 480000000000
			send_alert(task)
		end
	end
	
	def send_alert(task)
		#oh my god its taking forever!
		if task.name.eql?("BVT")
			RunTimeNotifier.bvt
		end
	end

end
