module SuitesHelper
	
	def get_build_tags(suite_name)
		tag_list = @suites[suite_name].map(&:mobilizer_build_tag).flatten
		return tag_list
	end

end
