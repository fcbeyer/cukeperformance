class AddFailureImageToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :failure_image, :text

  end
end
