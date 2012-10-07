require 'json'

class Build
	#this will store all the elements for a specific feature
	attr_reader :date, :time, :duration, :convertedDuration, :features
	attr_writer :duration, :convertedDuration, :features
	def initialize(date, time)
		@date = date
		@time = time
		@duration = 0
		@convertedDuration = 0
		@features = []
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

class Feature
	#this will store all of our features
	attr_reader :keyword, :name, :duration, :convertedDuration, :scenarios
	attr_writer :duration, :convertedDuration, :scenarios
	def initialize(keyword, name)
		@keyword = keyword
		@name = name
		@duration = 0
		@convertedDuration = 0
		@scenarios = []
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

class Scenario
	#this will store all the info for a scenario
	attr_reader :keyword, :name, :duration, :convertedDuration, :steps
	attr_writer :duration, :convertedDuration, :steps
	def initialize(keyword, name)
		@keyword = keyword
		@name = name
		@duration = 0
		@convertedDuration = 0
		@steps = []
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

class Step
	#this will be where we track step information
	attr_reader :keyword, :name, :duration, :convertedDuration, :status
	attr_writer :duration, :convertedDuration, :status
	def initialize(keyword, name, duration, convertedDuration, status)
		@keyword = keyword
		@name = name
		@duration = duration
		@convertedDuration = convertedDuration
		@status = status
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
end

#goes through jobs and pulls out performance information from json dumps
#requires Pickle Job name, last entry for date_time on that model (so we only pull new data)
#Example   BuildVerificationTest = BVT (so use BVT when calling from the controller)
def getBuildList(jobName,build_stamp)
	build_list = []
	#step through file directory and find cucumber.json
	dirPath = Dir.pwd + "/" + jobName + "/builds"
	#dirPath = "C:/local/projects/Git/CukePerformance/Performance/builds"
	dir = dirPurge(dirPath,build_stamp)
	dir.each do |buildFolder|
		curPath = dirPath + "/" + buildFolder
		if Dir.exists?(curPath)#get the date time stamp from the name of this directory
			build = buildFolder.split("_")
			date = build[0]
			time = build[1]
			current_build = Build.new(date,time)

			#now we have the cucumber.json file location, lets process it
			filePath = dirPath + "/" + buildFolder + "/cucumber-html-reports/cucumber.json"
			file = File.read(filePath)
			document = JSON.parse(file)

			feature_list = []
			featureTotal = 0

			document.each do |feature|
				current_feature = Feature.new(feature['keyword'],feature['name'])
				scenarioTotal = 0
				scenario_list = []
				feature['elements'].each do |scenario|
					current_scenario = Scenario.new(scenario['keyword'],scenario['name'])		
					stepTotal = 0
					step_list = []
					scenario['steps'].each do |step|
						stepTotal = stepTotal + step['result']['duration']
						dur = step['result']['duration']
						convDur = Time.at((dur / 1000000000.00)).gmtime.strftime('%R:%S:%L')
						step_list.push(Step.new(step['keyword'],step['name'],dur,convDur,step['result']['status']))
					end
					current_scenario.duration = stepTotal
					current_scenario.convertedDuration = Time.at((stepTotal / 1000000000.00)).gmtime.strftime('%R:%S:%L')
					current_scenario.steps = step_list
					scenario_list.push(current_scenario)
					scenarioTotal = scenarioTotal + stepTotal
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

			current_build.duration = totalTime
			current_build.convertedDuration = Time.at(totalTime / 1000000000.00).gmtime.strftime('%R:%S:%L')
			current_build.features = feature_list
			build_list.push(current_build)
		end
	end

	return build_list
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