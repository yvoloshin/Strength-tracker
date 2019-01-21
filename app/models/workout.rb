class Workout < ActiveRecord::Base
	belongs_to :workout_type
	has_many :exercises, dependent: :destroy
	belongs_to :user

	accepts_nested_attributes_for :exercises

	# self = @workouts
	# make each row an exercise
	def self.as_csv(options = {})
	  CSV.generate do |csv|
	    all.each do |item|

				empty_line = Array.new
	  		csv << empty_line

	    	heading = Array.new
	    	heading << item.created_at.strftime("%B %e, %Y")
	    	heading << item.workout_type_name
	    	csv << heading

	    	empty_line = Array.new
	  		csv << empty_line

	    	column_headers = ['Exercise Name', 'Set', 'Reps', 'Load']
	    	csv << column_headers
	      exercises = Exercise.where({workout_id: item.id})
	      exercises.each do |exercise| 
	      	i=1     	
	      	exercise.completed_sets.each do |set|
	      		row = Array.new
	      		row << exercise.name
	      		row << i
	      		row << set.reps
	      		row << set.load
	      		csv << row
	      		i += 1  
      		end   	
	    	end	    	
	    end

	    empty_line = Array.new
	  	csv << empty_line

	  end
	end

	def compare_with_previous(current_workout, previous_workout, exercise_id, exercise_name)
		#current_workout_sets_for_exercise = CompletedSet.where({exercise_id: exercise_id})
		current_workout_sets_for_exercise = CompletedSet.all
		previous_workout_sets_for_exercise = Workout.joins(exercises: :completed_sets).where(exercises: {name: exercise_name}, id: previous_workout.id).count
	return current_workout_sets_for_exercise.inspect + " <br /> " + exercise_name + ' ' + previous_workout_sets_for_exercise.inspect

	end

end
