class WorkoutsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
	end

	def new
		@workout_type = WorkoutType.find(params[:workout_type_id])
		@workout = Workout.new
		@workout.type = @workout_type.type_name
		

	end
	
	

	def create
	# 	@place=current_user.places.create(place_params)
	# 	if @place.valid?
	# 		redirect_to root_path
	# 	else
	# 		render :new, :status => :unprocessable_entity
	# 	end
	 end
end
