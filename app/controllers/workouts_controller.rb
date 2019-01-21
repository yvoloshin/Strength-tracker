class WorkoutsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@workouts = current_user.workouts.all.order(created_at: :desc)

		respond_to do |format|
	    format.html
	    format.csv { send_data @workouts.as_csv }
	    format.xls
  	end
	end

	def new
		if params[:workout_type_id] == 'last'
			@workout_type = last_workout_type
		else @workout_type = current_workout_type
		end
		@workout = Workout.new
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
			if sets.nil?
				# If the user has not specified the number of sets, make sets = 1.
	  		sets = 1
	  	end 
	  	@completed_sets = Array.new(sets) { exercise.completed_sets.build }	
		end
	end
	
	def last_workout_type
		last_workout_type_id = current_user.workouts.last.workout_type_id
		WorkoutType.find(last_workout_type_id)
	end
		
	def create
		@workout_type = WorkoutType.find(params[:workout_type_id])
		@workout = @workout_type.workouts.create(workout_params.merge(:user => current_user))
		workout_type = @workout_type.type_name

		@workout.update(workout_type_name: workout_type)

		if @workout.valid?
			redirect_to user_workouts_path(current_user)
		else
			render :new, :status => :unprocessable_entity
		end
		
	end

	def show
		@workout = Workout.find(params[:id])
		@user = current_user
		@exercise_names = Array.new
		@workout.exercises.each do |exercise|
			@exercise_names.push(exercise.name)
		end
		@exercise_names = @exercise_names.uniq
		@workouts = current_user.workouts.all.order(created_at: :desc)
		@index = @workouts.index(@workout)
		@workouts_current_routine = Workout.where(workout_type_id: @workout.workout_type_id).order(created_at: :desc)
		@previous_workout = @workouts_current_routine[@workouts_current_routine.index(@workout)+1]
		
		unless @previous_workout.nil?
			@comparisons = @workout.compare_with_previous(@workout, @previous_workout)
		end
		
	end



	def destroy
		@workout = Workout.find(params[:id])
    @user = current_user
		
    @workout.destroy
    redirect_to user_workouts_path(current_user)
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
