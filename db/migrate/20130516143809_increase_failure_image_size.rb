class IncreaseFailureImageSize < ActiveRecord::Migration
  def change
  	change_column :steps, :failure_image, :text, :limit => 4294967295
  end
end
