require 'json'

class Build
	#this will store all the elements for a specific feature
	attr_reader :date, :time, :runstamp, :duration, :convertedDuration, :features, :browser, :os, :mobilizer, :mobilizer_build_tag, :url, :status
	attr_writer :duration, :convertedDuration, :features, :status
	def initialize(date, time, runstamp, mobilizer_build_tag, mobilizer, os, url, browser)
		@date = date
		@time = time
		@runstamp = runstamp
		@duration = 0
		@convertedDuration = 0
		@features = []
		@browser = browser
		@os = os
		@mobilizer = mobilizer
		@mobilizer_build_tag = mobilizer_build_tag
		@url = url
		@status = "" 
	end
	
	def to_csv
		#prints pretty csv format
		"#@date #@time,#@duration"
	end

	def getFullName
		#returns keyword + name
		fullName = @date + "_" + @time
		return fullName
	end
end

class JsonFeature
	#this will store all of our features
	attr_reader :keyword, :name, :duration, :convertedDuration, :scenarios, :status
	attr_writer :duration, :convertedDuration, :scenarios, :status
	def initialize(keyword, name)
		@keyword = keyword
		@name = name
		@duration = 0
		@convertedDuration = 0
		@scenarios = []
		@status = ""
	end

	def to_csv
		#prints csv format
		"#@keyword,#@name,#@duration,#@convertedDuration"
	end

	def to_csv_pretty
		#prints pretty csv format
		"\t #@keyword,#@name,#@duration,#@convertedDuration"
	end

	def getFullName
		#returns keyword + name
		fullName = @keyword + " " + @name
		return fullName
	end
end

class JsonScenario
	#this will store all the info for a scenario
	attr_reader :keyword, :name, :duration, :convertedDuration, :steps, :status
	attr_writer :duration, :convertedDuration, :steps, :status
	def initialize(keyword, name)
		@keyword = keyword
		@name = name
		@duration = 0
		@convertedDuration = 0
		@steps = []
		@status = ""
	end

	def to_csv
		#prints csv format
		"#@keyword,#@name,#@duration,#@convertedDuration"
	end

	def to_csv_pretty
		#prints pretty csv format
		"\t\t #@keyword,#@name,#@duration,#@convertedDuration"
	end

	def getFullName
		#returns keyword + name
		fullName = @keyword + " " + @name
		return fullName
	end
end

class JsonStep
	#this will be where we track step information
	attr_reader :keyword, :name, :duration, :convertedDuration, :status, :reason_for_failure, :failure_image
	attr_writer :duration, :convertedDuration, :status, :reason_for_failure, :failure_image
	def initialize(keyword, name, duration, convertedDuration, status, reason_for_failure, failure_image)
		@keyword = keyword
		@name = name
		@duration = duration
		@convertedDuration = convertedDuration
		@status = status
		@reason_for_failure = reason_for_failure
		@failure_image = failure_image
	end

	def to_csv
		#prints csv format
		"#@keyword,#@name,#@duration,#@convertedDuration,#@status"
	end

	def to_csv_pretty
		#prints pretty csv format
		"\t\t\t #@keyword,#@name,#@duration,#@convertedDuration,#@status"
	end

	def getFullName
		#returns keyword + name
		fullName = @keyword + " " + @name
		return fullName
	end
end

def write_build(build,output)
	output.puts build.to_csv
	build.features.each do |feature|
		output.puts feature.to_csv
		feature.scenarios.each do |scenario|
			output.puts scenario.to_csv
			scenario.steps.each do |step|
				output.puts step.to_csv
			end
		end
	end
end

def write_build_pretty(build,output)
	#build is always first line, no indentation needed to make it "pretty"
	output.puts build.to_csv
	build.features.each do |feature|
		output.puts feature.to_csv_pretty
		feature.scenarios.each do |scenario|
			output.puts scenario.to_csv_pretty
			scenario.steps.each do |step|
				output.puts step.to_csv_pretty
			end
		end
	end
end

def build_bar(build)
	#lets try to imitate what a bar graph needs for google charts
	entry = Array.new
	entry.push(build.getFullName)
	entry.push(build.duration)
	return entry
end

def build_categories
	categories = ["Build Date","Duration"]
	return categories
end

def feature_bar(build)
	entry = Array.new
	entry.push(build.getFullName)
	build.features.each do |feature|
		entry.push(feature.duration)
	end
	return entry
end

def define_feature_categories(build)
	categories = Array.new
	build.features.each do |feature|
		categories.push(feature.name)
	end
	return categories
end

def dirPurge(dirPath, build_stamp)
	#get rid of directories we already have data for
	dropNum = 2
	if Dir.exists?(dirPath)
		dir = Dir.entries(dirPath)
		if build_stamp != "empty"
			dir.each do |buildFolder|
				if buildFolder == build_stamp
					dropNum = dir.index(buildFolder) + 1
				end
			end
		end
		dir = dir.drop(dropNum)
		return dir
	else
		#not a valid directory (does not exist must let App know so User can be notified)
		return false
	end
end

#goes through jobs and pulls out performance information from json dumps
#requires Pickle Job name, last entry for date_time on that model (so we only pull new data)
#Example   BuildVerificationTest = BVT (so use BVT when calling from the controller)
def getBuildList(file_path,build_stamp)
	build_list = []
	#step through file directory and find cucumber.json
	#dirPath = file_path + "/builds"
	dirPath = "C:/Users/cbrachmann/workspace/CukePerformance/app/Performance/builds"
	dir = dirPurge(dirPath,build_stamp)
	if dir.kind_of?(Array)
		dir.each do |buildFolder|
			curPath = dirPath + "/" + buildFolder
			if Dir.exists?(curPath)#get the date time stamp from the name of this directory
				build = buildFolder.split("_")
				date = build[0]
				time = build[1]
				dateArray = date.split("-")
				timeArray = time.split("-")
				dt = []
				dateArray.each do |d|
					dt.push(d.to_i)
				end
				timeArray.each do |t|
					dt.push(t.to_i)
				end
				runstamp = Time.new(dt[0],dt[1],dt[2],dt[3],dt[4],dt[5])
				systemDatafilePath = dirPath + "/" + buildFolder + "/archive/systemData.json"
				systemDataFile = File.read(systemDatafilePath)
				systemData = JSON.parse(systemDataFile)
				#mobilizer_build_tag, mobilizer, os, url, browser
				current_build = Build.new(date,time,runstamp,systemData['mobilizer_build_tag'],systemData['mobilizer'],systemData['os'],systemData['url'],systemData['browser'])
	
				#now we have the cucumber.json file location, lets process it
				filePath = dirPath + "/" + buildFolder + "/archive/cucumber.json"
				file = File.read(filePath)
				document = JSON.parse(file)
	
				feature_list = []
				featureTotal = 0
	
				document.each do |feature|
					current_feature = JsonFeature.new(feature['keyword'],feature['name'])
					scenarioTotal = 0
					scenario_list = []
					feature['elements'].each do |scenario|
						current_scenario = JsonScenario.new(scenario['keyword'],scenario['name'])		
						stepTotal = 0
						step_list = []
						scenario['steps'].each do |step|
							stepErrorMessage = ''
							stepFailureImage = ''
							stepTotal = stepTotal + step['result']['duration']
							dur = step['result']['duration']
							convDur = Time.at((dur / 1000000000.00)).gmtime.strftime('%R:%S:%L')
							if step['result']['status'] == "failed"
								current_scenario.status = "failed"
								current_feature.status = "failed"
								current_build.status = "failed"
								stepErrorMessage = step['result']['error_message']				
								#failed steps should have an image available:
								unless step['embeddings'].nil?
									stepFailureImage = step['embeddings'][0]['data']
								end					
							end
							step_list.push(JsonStep.new(step['keyword'],step['name'],dur,convDur,step['result']['status'],stepErrorMessage,stepFailureImage))
#							if !step['result']['error_message'].nil?
#								step_list.push(JsonStep.new(step['keyword'],step['name'],dur,convDur,step['result']['status'],step['result']['error_message']))
#							else
#								step_list.push(JsonStep.new(step['keyword'],step['name'],dur,convDur,step['result']['status'],""))
#							end
						end
						if current_scenario.status.empty?
							#all the steps passed
							current_scenario.status = "passed"
						end
						current_scenario.duration = stepTotal
						current_scenario.convertedDuration = Time.at((stepTotal / 1000000000.00)).gmtime.strftime('%R:%S:%L')
						current_scenario.steps = step_list
						scenario_list.push(current_scenario)
						scenarioTotal = scenarioTotal + stepTotal
					end
					if current_feature.status.empty?
							#all the steps passed
							current_feature.status = "passed"
					end
					current_feature.duration = scenarioTotal
					current_feature.convertedDuration = Time.at((scenarioTotal / 1000000000.00)).gmtime.strftime('%R:%S:%L')
					current_feature.scenarios = scenario_list
					feature_list.push(current_feature)
					featureTotal = featureTotal + scenarioTotal
				end
	
				totalTime = 0
				feature_list.each do |feature|
					totalTime = totalTime + feature.duration
				end
				
				if current_build.status.empty?
							#all the steps passed
							current_build.status = "passed"
				end
				current_build.duration = totalTime
				current_build.convertedDuration = Time.at(totalTime / 1000000000.00).gmtime.strftime('%R:%S:%L')
				current_build.features = feature_list
				build_list.push(current_build)
			end
		end
		return build_list
	else
		return false
	end
end

# output = File.new("bar.txt","w+")
# banner = define_feature_categories(build_list[0])
# banner.unshift("Build Date")
# data = Array.new
# data.push(banner)
# build_list.each do |build|
# 	data.push(feature_bar(build))
# end

# output.puts data.to_s

# output1 = File.new("rick.txt","w+")
# build_list.each do |build|
# 	write_build(build,output1)
# end