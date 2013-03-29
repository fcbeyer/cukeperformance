class AddIndexToSteps < ActiveRecord::Migration
  def change
  	add_index :steps, :scenario_id, :name => 'scenario_id_ix'
  end
end
