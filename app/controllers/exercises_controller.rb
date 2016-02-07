class ExercisesController < ApplicationController

	def new
		@workout_type = WorkoutType.find(params[:workout_type_id])
		@exercises = Array.new(10) { @workout_type.exercises.build }

	end

	def create
		@exercises = WorkoutType.find(params[:workout_type_id])
		@workout_type.exercises.create(exercise_params)
		redirect_to root_path

	end

	private

	def exercise_params
		params.require(:exercise).permit(:name)
	end

end
