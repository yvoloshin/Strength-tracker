class ExerciseType < ActiveRecord::Base
	attr_accessor :workout_type_id, :exercise_type_id, :weight_unit_id
	belongs_to :workout_type
	has_many :exercises
	belongs_to :weight_unit
end
