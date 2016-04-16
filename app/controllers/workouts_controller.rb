class WorkoutsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@workouts = current_user.workouts.all
	end

	def new
		@workout_type = current_workout_type
		# need to associate @workout and @workout_type
		@workout = Workout.new
		@workout.type = @workout_type.type_name
		@exercise_type_names_arr = @workout_type.exercise_types.map { |exercise_type| exercise_type.name }
		n = @workout_type.exercise_types.size
		puts n
		@exercises = Array.new(n) { @workout.exercises.build }
		i = 0
		while i<n do
			@exercises[i].name = @exercise_type_names_arr[i]
			i += 1
		end
		@exercises.delete_if {|exercise| exercise.name.empty? }
	end
		

	def create
		@workout_type = WorkoutType.find(params[:workout_type_id])
		#@workout_type = current_workout_type
		@workout = @workout_type.workouts.create(workout_params.merge(:user => current_user))

		if @workout.valid?
			redirect_to user_workouts_path(current_user)
			# redirect_to root_path
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def show
		@workout = Workout.find(params[:id])
		@user = current_user
	end


	helper_method :current_workout_type
	def current_workout_type
		if params[:workout_type_id].present?
            WorkoutType.find(params[:workout_type_id])
        else
		current_workout.workout_type
		end
	end

	def current_workout
		@current_workout ||= Workout.find(params[:id])
	end



	def workout_params
		params.require(:workout).permit(:type, :exercises_attributes => [:name, :sets, :reps, :load])
	end

	def exercise_params
		params.require(:exercise).permit(:name, :sets, :reps, :load)
	end

	def workout_type_params
		params.require(:workout_type).permit(:type_name, :exercise_types_attributes => [:name, :sets, :reps, :load])
	end

end
