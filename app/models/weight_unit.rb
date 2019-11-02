class WeightUnit < ActiveRecord::Base
	has_many :completed_sets
	has_many :exercise_types
	# accepts_nested_attributes_for :exercise_types
end