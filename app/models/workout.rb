class Workout < ActiveRecord::Base
	belongs_to :workout_type
	has_many :exercises
end
