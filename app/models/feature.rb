class Feature < ActiveRecord::Base
	has_many :scenarios, :dependent => :destroy
	belongs_to :suite
	
	#return fullName of a specific build
	def getFullName(feature_id)
		feature = Feature.find(feature_id)
		fullName = feature.keyword + "_" + feature.name
		return fullName
	end


end
