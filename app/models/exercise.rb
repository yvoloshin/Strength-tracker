class Exercise < ActiveRecord::Base
	belongs_to :workout
	has_many :completed_sets
	attr_accessor :workout_id, :exercise_id


end
