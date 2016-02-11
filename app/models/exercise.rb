class Exercise < ActiveRecord::Base
	belongs_to :workout
	attr_accessor :workout_id, :exercise_id


end
