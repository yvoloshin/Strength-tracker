class WorkoutsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@workouts = current_user.workouts.all

		respond_to do |format|
	    format.html
	    format.csv { send_data @workouts.as_csv }
	    format.xls
  	end

	end

	def new
		@workout_type = current_workout_type
		@workout = Workout.new
		@workout.type = @workout_type.type_name
		@exercise_type_names_arr = @workout_type.exercise_types.map { |exercise_type| exercise_type.name }
		@exercise_type_ids_arr = @workout_type.exercise_types.map { |exercise_type| exercise_type.id }
		number_of_exercises = @workout_type.exercise_types.size
		@exercises = Array.new(number_of_exercises) { @workout.exercises.build }
		
		i = 0
    while i<number_of_exercises do
			@exercises[i].name = @exercise_type_names_arr[i]
			@exercises[i].exercise_type_id = @exercise_type_ids_arr[i]
			i += 1
		end

		@exercises.delete_if {|exercise| exercise.name.empty? }

		@exercises.each do |exercise|
			sets = ExerciseType.find(exercise.exercise_type_id).sets
		  @completed_sets = Array.new(sets) { exercise.completed_sets.build }
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
