class WorkoutType < ActiveRecord::Base
	attr_accessor :exercise_attributes
	has_many :exercises

	accepts_nested_attributes_for :exercises
end
