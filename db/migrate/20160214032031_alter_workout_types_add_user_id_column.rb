class AlterWorkoutTypesAddUserIdColumn < ActiveRecord::Migration
  def change
  	add_column :workout_types, :user_id, :integer
    add_index :workout_types, :user_id
  end
end
