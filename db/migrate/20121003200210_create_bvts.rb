class CreateBvts < ActiveRecord::Migration
  def change
    create_table :bvts do |t|
      t.string :build_date
      t.string :build_time
      t.integer :duration
      t.string :duration_converted

      t.timestamps
    end
  end
end
