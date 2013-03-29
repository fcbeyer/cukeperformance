class AddIndexToSuites < ActiveRecord::Migration
  def change
  	add_index :suites, :name, :name => 'name_ix'
  end
end
