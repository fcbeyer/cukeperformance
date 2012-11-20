class GraphController < ApplicationController
  def suites
  	@suites = Suite.all
		@suites.sort! { |a,b| a.runstamp <=> b.runstamp}
  end

  def features
  end

  def scenarios
  end

  def steps
  end
end
