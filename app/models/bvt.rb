class Bvt < ActiveRecord::Base
	#date and time need to be unique but only when strung together?
	def getFullName(bvt_id)
		bvt_build = Bvt.find(bvt_id)
		fullName = bvt_build.build_date + "_" + bvt_build.build_time
		return fullName
	end
	
end
