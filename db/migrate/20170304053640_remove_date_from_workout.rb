class RemoveDateFromWorkout < ActiveRecord::Migration
  def change
  	remove_column :workouts, :date, :date
  end
end
