class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
    	t.string :type
    	t.date :date
      t.timestamps null: false
    end
  end
end
