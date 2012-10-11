class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.string :keyword
      t.string :name
      t.integer :duration, :limit => 8
      t.string :duration_converted
      t.integer :feature_id

      t.timestamps
    end
  end
end
