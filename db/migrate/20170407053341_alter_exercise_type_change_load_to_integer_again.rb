class AlterExerciseTypeChangeLoadToIntegerAgain < ActiveRecord::Migration
  def change
  	remove_column :exercise_types, :load, :string
  	add_column :exercise_types, :load, :integer
  end
end
