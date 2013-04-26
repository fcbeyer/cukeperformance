class AddIndexToFeatures < ActiveRecord::Migration
  def change
  	add_index :features, :suite_id, :name => 'suite_id_ix'
  end
end
