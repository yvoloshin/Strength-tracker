class WorkoutType < ActiveRecord::Base
	attr_accessor :exercise_type_attributes, :workout_type_id
	has_many :exercise_types, dependent: :destroy
	has_many :workouts
	belongs_to :user

	accepts_nested_attributes_for :exercise_types
end
