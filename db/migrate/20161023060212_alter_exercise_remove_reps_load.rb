class AlterExerciseRemoveRepsLoad < ActiveRecord::Migration
  def change
  	remove_column :exercises, :reps
  	remove_column :exercises, :load
  end
end
