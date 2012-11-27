class GraphController < ApplicationController
  def suites
  	suite_name = params[:suite_name]
  	@suites = Suite.where(name: suite_name)
  	@suites.sort! { |a,b| a.runstamp <=> b.runstamp}
  	respond_to do |format|
  		format.json {render json: @suites}
  		format.html {render html: @suites}
  	end
  end

  def features		
		# @features = Feature.find_by_sql("select f.name, f.duration, f.status, f.duration_converted, s.runstamp, s.build_date, s.build_time " +
																		# "from Features f " +
																		# "inner join Suites s on s.id = f.suite_id " +
																		# "where s.name = 'BVT'")
			#this is the equivalent of the above SQL statement
		suite_name = params[:suite_name]
		@features = Feature.joins(:suite).where(:suites => {:name => suite_name}).select("features.*,suites.runstamp,suites.build_time,suites.build_date")
		@features.sort! { |a,b| a.runstamp <=> b.runstamp}
		respond_to do |format|
			format.json {render json: @features}
			format.html {render html: @features}
  	end
  end

  def scenarios
  	suite_name = params[:suite_name]
		# @scenarios = Scenario.joins(:suite).where(:suites => {:name => suite_name}).select("scenarios.*,suites.runstamp,suites.build_time,suites.build_date")
		@scenarios = Scenario.find_by_sql("select sce.name, sce.duration, sce.status, sce.duration_converted, f.name as feature_name , sui.runstamp, sui.build_date, sui.build_time " + 
																			"from Scenarios sce " +
																			"inner join Features f on f.id = sce.feature_id " +
																			"inner join Suites sui on sui.id = f.suite_id " +
																			"where sui.name = '#{suite_name}'")
		@scenarios.sort! { |a,b| a.runstamp <=> b.runstamp}
		respond_to do |format|
			format.json {render json: @scenarios}
			format.html {render html: @scenarios}
  	end  	
  end

  def steps
  	suite_name = params[:suite_name]
		# @scenarios = Scenario.joins(:suite).where(:suites => {:name => suite_name}).select("scenarios.*,suites.runstamp,suites.build_time,suites.build_date")
		@steps = Step.find_by_sql("select ste.name, ste.duration, ste.status, ste.duration_converted, f.name as feature_name, sce.name as scenario_name, sui.runstamp, sui.build_date, sui.build_time " + 
																			"from Steps ste " +
																			"inner join Scenarios sce on sce.id = ste.scenario_id " +
																			"inner join Features f on f.id = sce.feature_id " +
																			"inner join Suites sui on sui.id = f.suite_id " +
																			"where sui.name = '#{suite_name}'")
		@steps.sort! { |a,b| a.runstamp <=> b.runstamp}
		respond_to do |format|
			format.json {render json: @steps}
			format.html {render html: @steps}
  	end  
  end
end
