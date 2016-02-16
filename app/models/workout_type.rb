class WorkoutType < ActiveRecord::Base
	attr_accessor :exercise_type_attributes
	has_many :exercise_types, dependent: :destroy
	belongs_to :user

	accepts_nested_attributes_for :exercise_types
end
