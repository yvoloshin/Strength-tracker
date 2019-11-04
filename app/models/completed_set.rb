class CompletedSet < ActiveRecord::Base
	belongs_to :exercise
	belongs_to :weight_unit

	accepts_nested_attributes_for :weight_unit
end
