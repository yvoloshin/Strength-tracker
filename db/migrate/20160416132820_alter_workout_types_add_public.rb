class AlterWorkoutTypesAddPublic < ActiveRecord::Migration
  def change
  	add_column :workout_types, :public, :boolean
  end
end
