class WorkoutType < ActiveRecord::Base
	attr_accessor :exercise_type_attributes, :workout_type_id, :weight_unit_id
	has_many :exercise_types, dependent: :destroy
	has_many :workouts
	belongs_to :user

	accepts_nested_attributes_for :exercise_types

	# Implements search for workout types.
  # * *Args*    :
  #   - search query in string format
  # * *Returns* :
  #   - returns the workout types with names that contain one or more words from the query
  def self.search(query)
    where("LOWER(type_name) like ?", "%#{query}%")
  end

end
