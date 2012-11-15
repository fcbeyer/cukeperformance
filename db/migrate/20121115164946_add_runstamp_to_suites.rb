class AddRunstampToSuites < ActiveRecord::Migration
  def change
    add_column :suites, :runstamp, :datetime

  end
end
