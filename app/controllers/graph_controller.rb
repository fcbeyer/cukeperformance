class GraphController < ApplicationController
  def suites
  	@suites = Suite.all
		@suites.sort! { |a,b| a.runstamp <=> b.runstamp}
  end

  def features		
		# @features = Feature.find_by_sql("select f.name, f.duration, f.status, f.duration_converted, s.runstamp, s.build_date, s.build_time " +
																		# "from Features f " +
																		# "inner join Suites s on s.id = f.suite_id " +
																		# "where s.name = 'BVT'")
			#this is the equivalent of the above SQL statement
			@features = Feature.joins(:suite).where(:suites => {:name => 'BVT'}).select("features.*,suites.runstamp,suites.build_time,suites.build_date")
			@features.sort! { |a,b| a.runstamp <=> b.runstamp}
  end

  def scenarios
  end

  def steps
  end
end
