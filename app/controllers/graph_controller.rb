class GraphController < ApplicationController
	before_filter :get_suite_list
	
	def get_suite_list
		@suite_list = Suite.select(:name).uniq
	end
	
  def suites
  	@begin_date = Suite.first.runstamp
  	suite_name = params[:suite_name]
  	start_date = params[:begin_date]
  	finish_date = params[:end_date]
  	suite_name = params[:suite_name]
  	
  	start = (start_date.nil? ? Suite.first.runstamp : Time.new(start_date['year'],start_date['month'],start_date['day']))
  	finish = (finish_date.nil? ? Time.now : Time.new(finish_date['year'],finish_date['month'],finish_date['day'],23,59,59))
  	
  	@suites = Suite.where({:name => suite_name, :runstamp => start..finish})
  	@suites.sort! { |a,b| a.runstamp <=> b.runstamp}
  	respond_to do |format|
  		format.json {render json: @suites}
  		format.html {render html: @suites}
  	end
  end

  def features		
		@begin_date = Suite.first.runstamp
  	suite_name = params[:suite_name]
  	start_date = params[:begin_date]
  	finish_date = params[:end_date]
  	suite_name = params[:suite_name]
  	
  	start = (start_date.nil? ? Suite.first.runstamp : Time.new(start_date['year'],start_date['month'],start_date['day']))
  	finish = (finish_date.nil? ? Time.now : Time.new(finish_date['year'],finish_date['month'],finish_date['day'],23,59,59))
  	
		@features = Feature.joins(:suite).where(:suites => {:name => suite_name, :runstamp => start..finish}).select("features.*,suites.runstamp,suites.build_time,
			suites.build_date,suites.mobilizer,suites.browser")
		@features.sort! { |a,b| a.runstamp <=> b.runstamp}
		respond_to do |format|
			format.json {render json: @features}
			format.html {render html: @features}
  	end
  end

  def scenarios
  	@begin_date = Suite.first.runstamp
  	fname = params[:f_name]
  	start_date = params[:begin_date]
  	finish_date = params[:end_date]
  	suite_name = params[:suite_name]
  	
  	start = (start_date.nil? ? Suite.first.runstamp : Time.new(start_date['year'],start_date['month'],start_date['day']))
  	finish = (finish_date.nil? ? Time.now : Time.new(finish_date['year'],finish_date['month'],finish_date['day'],23,59,59))
  	
		@scenarios = Scenario.joins(:feature => :suite).where(:suites => {:name => suite_name, :runstamp => start..finish}).
			select("scenarios.*,suites.runstamp,suites.build_time,suites.build_date,suites.mobilizer,suites.browser,features.name as feature_name")
		@scenarios.sort! { |a,b| a.runstamp <=> b.runstamp}
		respond_to do |format|
			format.json {render json: @scenarios}
			format.html {render html: @scenarios}
  	end  	
  end

  def steps
  	@begin_date = Suite.first.runstamp
  	fname = params[:f_name]
  	sname = params[:s_name]
  	start_date = params[:begin_date]
  	finish_date = params[:end_date]
  	suite_name = params[:suite_name]
  	
  	start = (start_date.nil? ? Suite.first.runstamp : Time.new(start_date['year'],start_date['month'],start_date['day']))
  	finish = (finish_date.nil? ? Time.now : Time.new(finish_date['year'],finish_date['month'],finish_date['day'],23,59,59))
  	
		@steps = Step.joins(:scenario => {:feature => :suite}).where(:suites => {:name => suite_name,:runstamp => start..finish}).
			select("steps.*,suites.runstamp,suites.build_time,suites.build_date,suites.mobilizer,suites.browser,
				features.name as feature_name, scenarios.name as scenario_name")
		@steps.sort! { |a,b| a.runstamp <=> b.runstamp}
		respond_to do |format|
			format.json {render json: @steps}
			format.html {render html: @steps}
  end
  end
  
  def summary
  	suite_name = params[:suite_name]
  	@summary = Suite.order("id desc").where(name: suite_name).limit(10)
  	@summary.sort! { |a,b| a.runstamp <=> b.runstamp}
  	respond_to do |format|
  		format.json {render json: @summary}
  		format.html {render html: @summary}
  	end
  end
  
  
  
  
	# @features = Feature.find_by_sql("select f.name, f.duration, f.status, f.duration_converted, s.runstamp, s.build_date, s.build_time " +
																# "from Features f " +
																# "inner join Suites s on s.id = f.suite_id " +
																# "where s.name = 'BVT'")
	#this is the equivalent of the above SQL statement
  
  # @scenarios = Scenario.find_by_sql("select sce.name, sce.duration, sce.status, sce.duration_converted, f.name as feature_name , sui.runstamp, sui.build_date, sui.build_time " + 
																			# "from Scenarios sce " +
																			# "inner join Features f on f.id = sce.feature_id " +
																			# "inner join Suites sui on sui.id = f.suite_id " +
																			# "where sui.name = '#{suite_name}'")
																			
	# @steps = Step.find_by_sql("select ste.name, ste.duration, ste.status, ste.duration_converted, f.name as feature_name, sce.name as scenario_name, sui.runstamp, sui.build_date, sui.build_time " + 
																			# "from Steps ste " +
																			# "inner join Scenarios sce on sce.id = ste.scenario_id " +
																			# "inner join Features f on f.id = sce.feature_id " +
																			# "inner join Suites sui on sui.id = f.suite_id " +
																			# "where sui.name = '#{suite_name}'")
end
