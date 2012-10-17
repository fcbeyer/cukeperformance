class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :keyword
      t.string :name
      t.integer :duration, :limit => 8
      t.string :duration_converted
      t.string :status
      t.integer :scenario_id

      t.timestamps
    end
  end
end
