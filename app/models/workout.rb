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

	# Returns a hash containing comparisons between the number of sets,
	# the total weight lifted, or the total reps (for bodyweight exercises)
	# for the same exercise between two recorded workouts belonging to the same routine
	def compare_with_previous(workout, previous_workout)
		comparisons = Hash.new

		workout.exercises.each do |exercise|
			comparisons[exercise.name] = Hash.new

			current_sets = get_total_sets_count(workout, exercise.name)
			previous_sets = get_total_sets_count(previous_workout, exercise.name)
			difference_sets = current_sets - previous_sets

			if difference_sets == 0
				comparisons[exercise.name][:sets_message] = 'No change in number of sets'
			elsif difference_sets > 0
				comparisons[exercise.name][:sets_message] = "#{difference_sets} more sets this time!"
			elsif difference_sets < 0
				comparisons[exercise.name][:sets_message] = "#{difference_sets} fewer sets this time"				
			end	

			# Determine whether this exercise is a body weight exercise 
			check_zero_load_current_workout = get_sum_load(workout, exercise.name).nil? || get_sum_load(workout, exercise.name) == 0
			check_zero_load_previous_workout = get_sum_load(previous_workout, exercise.name).nil? || get_sum_load(previous_workout, exercise.name) == 0
			bodyweight = check_zero_load_current_workout && check_zero_load_previous_workout

			# all results in lb
			current_total_results = get_total_results(workout, exercise.name, bodyweight)
			previous_total_results = get_total_results(previous_workout, exercise.name, bodyweight)
			difference_total_results = current_total_results - previous_total_results

			if bodyweight
				if difference_total_results == 0
				comparisons[exercise.name][:total_weight_or_reps_message] = 'No change in total number of reps'
				elsif difference_total_results > 0
					comparisons[exercise.name][:total_weight_or_reps_message] = "#{difference_total_results} more reps this time!"
				elsif difference_total_results < 0
					comparisons[exercise.name][:total_weight_or_reps_message] = "#{difference_total_results.abs} fewer reps this time"				
				end

			else
				if difference_total_results == 0
				comparisons[exercise.name][:total_weight_or_reps_message] = 'No change in total amount of weight lifted'
				elsif difference_total_results > 0
					comparisons[exercise.name][:total_weight_or_reps_message] = "#{difference_total_results} more total pounds lifted this time!"
				elsif difference_total_results < 0
					comparisons[exercise.name][:total_weight_or_reps_message] = "#{difference_total_results.abs} fewer total pounds lifted this time"				
				end
			end		
		end

		return comparisons
	end

	# Returns the number of sets for an exercise completed in a given workout
	def get_total_sets_count(workout, exercise_name)
		Workout.joins(exercises: :completed_sets).where(exercises: {name: exercise_name}, id: workout.id).count
	end

	# Returns total weight lifted, or the total number of reps for a bodyweight exercise,
	# for an exercise completed in a given workout
	def get_total_results(workout, exercise_name, bodyweight)
		sets_results = CompletedSet.joins(:exercise).where(exercises: {name: exercise_name, workout_id: workout.id}).order("exercises.created_at").as_json

		total_results = 0

		if bodyweight
			sets_results.each do |item|
				if item.key?('reps') && !item['reps'].nil?
					total_results += item['reps'] 				
				end 
			end

			return total_results
		else
			sets_results.each do |item|
				if item.key?('load') && item.key?('reps') && !item['load'].nil? && !item['reps'].nil?
					#abort item.inspect
					if item.key?('weight_unit_id') && !item['weight_unit_id'].nil?
						weight_unit = WeightUnit.find(item['weight_unit_id'])
						conversion_factor_to_lb = weight_unit.conversion_factor_to_lb
					else
						conversion_factor_to_lb = 1
					end		
					total_results += item['load'] * item['reps'] * conversion_factor_to_lb 			
				end 
			end
			# return results in lb
			return total_results
		end 
	end

	# Returns the sum of loads for all sets of an exercise
	def get_sum_load(workout, exercise_name)
		CompletedSet.joins(:exercise).where(exercises: {name: exercise_name, workout_id: workout.id}).order("exercises.created_at").sum("load")		
	end
end
