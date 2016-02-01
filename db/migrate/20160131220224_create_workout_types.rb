class CreateWorkoutTypes < ActiveRecord::Migration
  def change
    create_table :workout_types do |t|
    	t.string :type_name
      t.timestamps null: false
    end
  end
end
