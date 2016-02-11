class WorkoutTypesController < ApplicationController

	def index
		@workout_types = WorkoutType.all
	end

	def new
		@workout_type = WorkoutType.new
		@exercise_types = 10.times { @workout_type.exercise_types.build }
	end

	def create
		@workout_type = WorkoutType.create(workout_type_params)
		#@exercise_types = ExerciseTypes.create(params[:exercises_attributes])
		if @workout_type.valid?
			redirect_to root_path
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def workout_type_params
		params.require(:workout_type).permit(:type_name, exercise_types_attributes: [:name, :sets, :reps, :load])
	end

	def exercise_params
		params.require(:exercise).permit(:name, :sets, :reps, :load)
	end

end
