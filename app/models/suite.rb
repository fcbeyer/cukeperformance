class Suite < ActiveRecord::Base
	#date and time need to be unique but only when strung together?
	def getFullName(suite_id)
		suite_build = Suite.find(suite_id)
		fullName = suite_build.build_date + "_" + suite_build.build_time
		return fullName
	end
end
