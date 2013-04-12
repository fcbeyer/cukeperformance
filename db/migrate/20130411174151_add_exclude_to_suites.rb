class AddExcludeToSuites < ActiveRecord::Migration
  def change
    add_column :suites, :exclude, :boolean, :default => false

  end
end
