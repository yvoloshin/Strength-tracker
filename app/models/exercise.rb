class Exercise < ActiveRecord::Base
	belongs_to :workout
	has_many :completed_sets, dependent: :destroy
	attr_accessor :workout_id, :exercise_type_id

	accepts_nested_attributes_for :completed_sets


end
