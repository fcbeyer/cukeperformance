class AddIndexToScenarios < ActiveRecord::Migration
  def change
  	add_index :scenarios, :feature_id, :name => 'feature_id_ix'
  end
end
