class AlterWorkoutsAddWorkoutTypeIdColumn < ActiveRecord::Migration
  def change
  	add_column :workouts, :workout_type_id, :integer
    add_index :workouts, :workout_type_id
  end
end
