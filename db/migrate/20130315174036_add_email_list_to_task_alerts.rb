class AddEmailListToTaskAlerts < ActiveRecord::Migration
  def change
    add_column :task_alerts, :email_list, :string

  end
end
