class AlterWorkoutTypesAddDescription < ActiveRecord::Migration
  def change
  	add_column :workout_types, :description, :text
  end
end
