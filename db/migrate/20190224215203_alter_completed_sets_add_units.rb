class AlterCompletedSetsAddUnits < ActiveRecord::Migration
  def change
  	add_column :completed_sets, :units, :string
  	add_column :exercise_types, :units, :string
  end
end
