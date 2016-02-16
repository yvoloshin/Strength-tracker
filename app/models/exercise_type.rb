class ExerciseType < ActiveRecord::Base
	attr_accessor :workout_type_id, :exercise_type_id
	belongs_to :workout_type
end
