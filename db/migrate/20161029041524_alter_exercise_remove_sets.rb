class AlterExerciseRemoveSets < ActiveRecord::Migration
  def change
  	remove_column :exercises, :sets, :integer
  	remove_column :exercises, :reps, :integer
  	remove_column :exercises, :load, :integer
  end
end
