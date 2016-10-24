class Exercise < ActiveRecord::Base
	belongs_to :workout
	has_many :sets, dependent: :destroy
	attr_accessor :workout_id, :exercise_id


end
