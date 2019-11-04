class AlterCompletedSetsExerciseTypesAddUnitIds < ActiveRecord::Migration
  def change
  	remove_column :completed_sets, :units, :string
  	remove_column :exercise_types, :units, :string
  	add_column :completed_sets, :weight_unit_id, :integer
  	add_column :exercise_types, :weight_unit_id, :integer
  end
end
