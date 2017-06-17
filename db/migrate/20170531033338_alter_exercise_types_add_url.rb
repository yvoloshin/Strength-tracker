class AlterExerciseTypesAddUrl < ActiveRecord::Migration
  def change
  	add_column :exercise_types, :url, :string
  end
end
