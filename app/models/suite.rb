class Suite < ActiveRecord::Base
	has_many :features, :dependent => :destroy
	#date and time need to be unique but only when strung together?
	
	#return fullName of a specific build
	def getFullName(suite_id)
		suite_build = Suite.find(suite_id)
		fullName = suite_build.build_date + "_" + suite_build.build_time
		return fullName
	end
	
	#get the last build for a specific automation suite
	#requires: suite name
	def getLastBuild(jobName)
	  #do nothing
	end
end
