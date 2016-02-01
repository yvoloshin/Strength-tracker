class WorkoutTypesController < ApplicationController

	def index
		@workout_types = WorkoutType.all
	end

	def new
		@workout_type = WorkoutType.new
	end

	def create

	end

end
