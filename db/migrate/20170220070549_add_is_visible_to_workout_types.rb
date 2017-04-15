class AddIsVisibleToWorkoutTypes < ActiveRecord::Migration
  def change
  	add_column :workout_types, :is_visible, :boolean
  end
end
