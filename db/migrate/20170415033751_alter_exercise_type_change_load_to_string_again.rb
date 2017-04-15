class AlterExerciseTypeChangeLoadToStringAgain < ActiveRecord::Migration
  def change
  	remove_column :exercise_types, :load, :integer
  	add_column :exercise_types, :load, :string
  end
end
