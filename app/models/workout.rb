class Workout < ActiveRecord::Base
	belongs_to :workout_type
	has_many :exercises
	belongs_to :user

	accepts_nested_attributes_for :exercises

end
