class AlterExerciseTypeChangeLoadToString < ActiveRecord::Migration
  def self.up
    change_table :exercise_types do |t|
      t.change :load, :string
    end
  end
  def self.down
    change_table :exercise_types do |t|
      t.change :load, :integer
    end
  end
end
