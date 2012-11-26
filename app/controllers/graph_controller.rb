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
  end

  def steps
  end
end
