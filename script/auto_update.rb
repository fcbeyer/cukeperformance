require 'getoptlong'

def auto_create_dub(cuke_path,cuke_name,cuke_file)
	send_email = true
	cuke_results = CukeParser.json_complete(cuke_path,cuke_file,"systemData")
	puts cuke_results.converted_duration
	puts cuke_results.browser
	puts cuke_results.url
	file = File.new("results.txt","w+")
	CukeParser.write_pretty(cuke_results,file)
end

def auto_create(cuke_path,cuke_name,cuke_file)
	send_email = true
	cuke_results = CukeParser.json_complete(cuke_path,cuke_file,"systemData")
	suite = Suite.new({:build_date => cuke_results.date,:build_time => cuke_results.time,:runstamp => cuke_results.runstamp,:duration => cuke_results.duration,
						:duration_converted => cuke_results.converted_duration,:browser => cuke_results.browser,:os => cuke_results.os,:mobilizer => cuke_results.branch_number,
						:mobilizer_build_tag => cuke_results.branch_build_tag,:url => cuke_results.url,:name => cuke_name,:status => cuke_results.status,:exclude => false})
	suite.save
	cuke_results.features.each do |cur_feature|
		#save each feature
		feature = Feature.new({:keyword => cur_feature.keyword,:name => cur_feature.name,:duration => cur_feature.duration,
								:duration_converted => cur_feature.converted_duration,:suite_id => suite.id,:status => cur_feature.status})
		feature.save
		cur_feature.scenarios.each do |cur_scenario|
			#save each scenario
			scenario = Scenario.new({:keyword => cur_scenario.keyword,:name => cur_scenario.name,:duration => cur_scenario.duration,
									:duration_converted => cur_scenario.converted_duration,:feature_id => feature.id,:status => cur_scenario.status})
			scenario.save
			cur_scenario.steps.each do |cur_step|
				#save each step
				step = Step.new({:keyword => cur_step.keyword,:name => cur_step.name,:duration => cur_step.duration,:duration_converted => cur_step.converted_duration,
								:status => cur_step.status,:scenario_id => scenario.id,:reason_for_failure => cur_step.reason_for_failure,:failure_image => cur_step.failure_image})
				step.save
			end
		end
	end
end

def setup_data
	options = {}
	opts = GetoptLong.new(
												['--cuke_path', GetoptLong::REQUIRED_ARGUMENT],
												['--cuke_file', GetoptLong::REQUIRED_ARGUMENT],
												['--cuke_name', GetoptLong::REQUIRED_ARGUMENT])
	opts.each do |option, arg|
		case option
			when '--cuke_name'
				options[:cuke_name] = arg
			when '--cuke_path'
				options[:cuke_path] = arg
				when '--cuke_file'
				options[:cuke_file] = arg
		end
	end
	return options
end

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require_relative '..\config\environment.rb'
options = setup_data
auto_create(options[:cuke_path],options[:cuke_name],options[:cuke_file])