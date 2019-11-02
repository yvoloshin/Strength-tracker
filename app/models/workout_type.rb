class WorkoutType < ActiveRecord::Base
	attr_accessor :exercise_type_attributes, :workout_type_id, :weight_unit_id
	has_many :exercise_types, dependent: :destroy
	has_many :workouts
	belongs_to :user

#	accepts_nested_attributes_for :exercise_types, reject_if: lambda { |attributes| attributes['name'].blank? }
accepts_nested_attributes_for :exercise_types


	# Implements search for workout types.
  # * *Args*    :
  #   - search query in string format
  # * *Returns* :
  #   - returns the workout types with names that contain one or more words from the query
  def self.search(query)
    where("LOWER(type_name) like ?", "%#{query}%")
  end

  # Returns id of the weight unit of exercise with given name belonging to given workout_type
  def get_weight_unit_for_exercise(workout_type, exercise_name)
    return ExerciseType.find_by(name: exercise_name, workout_type_id: workout_type.id).weight_unit.id.to_int
  end

end
