class CreateTaskAlerts < ActiveRecord::Migration
  def change
    create_table :task_alerts do |t|
      t.string :browser
      t.integer :time_limit, :limit => 8
      t.integer :task_id

      t.timestamps
    end
  end
end
