class AddFailureToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :reason_for_failure, :string

  end
end
