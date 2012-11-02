class AddStatusToSuiteScenarioandFeature < ActiveRecord::Migration
	AFFECTED_TABLES = [:suites, :scenarios, :features]
  def self.up
  	AFFECTED_TABLES.each do |t|
    	add_column t, :status, :string
   end
  end
  
  def self.down
  	AFFECTED_TABLES.each do |t|
    	remove_column t, :status
   	end
  end
end
