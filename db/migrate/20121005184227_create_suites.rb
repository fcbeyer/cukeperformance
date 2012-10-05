class CreateSuites < ActiveRecord::Migration
  def change
    create_table :suites do |t|
      t.string :build_date
      t.string :build_time
      t.integer :duration, :limit => 8
      t.string :duration_converted
      t.string :name

      t.timestamps
    end
  end
end
