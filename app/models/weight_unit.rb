class WeightUnit < ActiveRecord::Base
	has_many :completed_sets
	has_many :exercise_types

end