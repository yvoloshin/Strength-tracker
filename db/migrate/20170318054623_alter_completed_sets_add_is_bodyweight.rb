class AlterCompletedSetsAddIsBodyweight < ActiveRecord::Migration
  def change
  	add_column :completed_sets, :is_bodyweight, :boolean
  end
end
