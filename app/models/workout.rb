class Workout < ActiveRecord::Base
	belongs_to :workout_type
	has_many :exercises
	#belongs_to :user
end
