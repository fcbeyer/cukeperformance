class AddActiveToTaskAlerts < ActiveRecord::Migration
  def change
    add_column :task_alerts, :active, :boolean

  end
end
