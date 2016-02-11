class WorkoutType < ActiveRecord::Base
	attr_accessor :exercise_type_attributes
	has_many :exercise_types

	accepts_nested_attributes_for :exercise_types
end
