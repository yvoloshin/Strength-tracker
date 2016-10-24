class CreateSets < ActiveRecord::Migration
  def change
    create_table :sets do |t|
    	t.integer :reps
    	t.string :load
    	t.integer :exercise_id
      t.timestamps null: false
    end
  end
end
