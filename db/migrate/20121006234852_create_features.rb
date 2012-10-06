class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :keyword
      t.string :name
      t.integer :duration, :limit => 8
      t.string :duration_converted
      t.integer :suite_id

      t.timestamps
    end
  end
end
