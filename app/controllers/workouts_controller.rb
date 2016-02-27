class WorkoutsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@workout_type = WorkoutType.find(params[:workout_type_id])
		@workouts = @workout_type.workouts.all
	end

	# def new
	# 	@workout_type = WorkoutType.find(params[:workout_type_id])
	# 	@workout = Workout.new
	# 	@workout.type = @workout_type.type_name
	# 	@workout_type.exercise_types.each do |exercise_type|

	# 	n = @workout_type.exercise_types.count
	# 	@exercises = Array.new(n) { @workout.exercises.build }
	# 	# exercise.name  = exercise_type.name
	# end

	def new
		@workout_type = WorkoutType.find(params[:workout_type_id])
		#@workout = @workout_type.workouts.build
		@workout = Workout.new
		@workout.type = @workout_type.type_name
		@exercise_type_names_arr = @workout_type.exercise_types.map { |exercise_type| exercise_type.name }
		n = @workout_type.exercise_types.count
		@exercises = Array.new(n) { @workout.exercises.build }
		i = 0
		while i<n do
			@exercises[i].name = @exercise_type_names_arr[i]	
		end
			
	end
		

	def create
		@workout_type = WorkoutType.find(params[:workout_type_id])
		@workout = @workout_type.workouts.create(workout_params.merge(:user => current_user))

			if @workout.valid?
				redirect_to root_path
			else
				render :new, :status => :unprocessable_entity
			end
	end


	def workout_params
		params.require(:workout).permit(:name, exercise_attributes: [:name, :sets, :reps, :load])
	end

	def exercise_params
		params.require(:exercise).permit(:name, :sets, :reps, :load)
	end

end
