class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :display_name
      t.string :file_path
      t.boolean :active

      t.timestamps
    end
  end
end
