class CreateExerciseTypes < ActiveRecord::Migration
  def change
    create_table :exercise_types do |t|
    	t.string :name
    	t.integer :sets
    	t.integer :reps
    	t.integer :load
    	t.integer :workout_type_id
      t.timestamps null: false
      t.timestamps null: false
    end
    add_index :exercise_types, :workout_type_id
  end
end
