class WorkoutsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@workouts = current_user.workouts.all

		respond_to do |format|
	    format.html
	    format.csv { send_data @workouts.as_csv }
  	end

	end

	def new
		@workout_type = current_workout_type
		@workout = Workout.new
		@workout.type = @workout_type.type_name
		@exercise_type_names_arr = @workout_type.exercise_types.map { |exercise_type| exercise_type.name }
		number_of_exercises = @workout_type.exercise_types.size
		@exercises = Array.new(number_of_exercises) { @workout.exercises.build }
		
		i = 0
    while i<number_of_exercises do
			@exercises[i].name = @exercise_type_names_arr[i]
			i += 1
		end

		@exercises.delete_if {|exercise| exercise.name.empty? }

		# Assume 5 sets per exercise
		# Change to value of exercise_type.sets
		# To do this, need to add "exercise_type has_many exercises"
		@exercises.each do |exercise|
		  @completed_sets = Array.new(5) { exercise.completed_sets.build }
		end
	end
		

	def create
		@workout_type = WorkoutType.find(params[:workout_type_id])
		@workout = @workout_type.workouts.create(workout_params.merge(:user => current_user))

		if @workout.valid?
			redirect_to user_workouts_path(current_user)
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
		params.require(:workout).permit(:type, :exercises_attributes => [:name, :completed_sets_attributes => [:reps, :load]])
	end

end
