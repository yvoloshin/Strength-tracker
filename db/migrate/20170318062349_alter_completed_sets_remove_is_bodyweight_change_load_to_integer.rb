class AlterCompletedSetsRemoveIsBodyweightChangeLoadToInteger < ActiveRecord::Migration
  def change
  	remove_column :completed_sets, :is_bodyweight, :boolean
  	remove_column :completed_sets, :load, :string
  	add_column :completed_sets, :load, :integer
  end
end
