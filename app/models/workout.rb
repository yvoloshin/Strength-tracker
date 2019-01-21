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

	def compare_with_previous(workout, previous_workout)
		comparisons = Hash.new

		workout.exercises.each do |exercise|
			comparisons[exercise.name] = Hash.new

			current_sets = Workout.joins(exercises: :completed_sets).where(exercises: {name: exercise.name}, id: workout.id).count
			previous_sets = Workout.joins(exercises: :completed_sets).where(exercises: {name: exercise.name}, id: previous_workout.id).count
			difference_sets = current_sets - previous_sets

			if difference_sets == 0
				comparisons[exercise.name][:sets_message] = 'No change in number of sets'
			elsif difference_sets > 0
				comparisons[exercise.name][:sets_message] = "#{difference_sets} more sets this time!"
			elsif difference_sets < 0
				comparisons[exercise.name][:sets_message] = "#{difference_sets} fewer sets this time"				
			end	

			current_load = CompletedSet.joins(:exercise).where(exercises: {name: exercise.name, workout_id: workout.id}).select("load").order("exercises.created_at").as_json
			current_reps = CompletedSet.joins(:exercise).where(exercises: {name: exercise.name, workout_id: workout.id}).select("reps").order("exercises.created_at").as_json

			current_total_load = 0

			current_load.each_with_index do |item, index|
				if item.key?('load') && current_reps[index].key?('reps') && !item['load'].nil? && !current_reps[index]['reps'].nil?
					current_total_load += item['load'] * current_reps[index]['reps'] 
				end 
			end

			previous_load = CompletedSet.joins(:exercise).where(exercises: {name: exercise.name, workout_id: previous_workout.id}).select("load").order("exercises.created_at").as_json
			previous_reps = CompletedSet.joins(:exercise).where(exercises: {name: exercise.name, workout_id: previous_workout.id}).select("reps").order("exercises.created_at").as_json
			
			previous_total_load = 0

			previous_load.each_with_index do |item, index|
				if item.key?('load') && previous_reps[index].key?('reps') && !item['load'].nil? && !previous_reps[index]['reps'].nil?
					previous_total_load += item['load'] * previous_reps[index]['reps'] 
				end
			end

			difference_total_load = current_total_load - previous_total_load

			if difference_total_load == 0
				comparisons[exercise.name][:total_weight_or_reps_message] = 'No change in total amount of weight lifted'
			elsif difference_total_load > 0
				comparisons[exercise.name][:total_weight_or_reps_message] = "#{difference_total_load} more total pounds lifted this time!"
			elsif difference_total_load < 0
				comparisons[exercise.name][:total_weight_or_reps_message] = "#{difference_total_load} fewer total pounds lifted this time"				
			end

		end

		return comparisons
	end

end
