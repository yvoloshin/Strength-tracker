class AlterWorkoutRenameTypeToWorkoutTypeName < ActiveRecord::Migration
  def change
  	remove_column :workouts, :type, :string
  	add_column :workouts, :workout_type_name, :string
  end
end
