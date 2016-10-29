class CreateCompletedSets < ActiveRecord::Migration
  def change
    create_table :completed_sets do |t|
    	t.integer :reps
    	t.string :load
    	t.integer :exercise_id
      t.timestamps null: false
    end
  end
end
