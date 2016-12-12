class WorkoutTypesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@workout_types = WorkoutType.all
	end

	def new
		@workout_type = WorkoutType.new
		@exercise_types = Array.new(10) { @workout_type.exercise_types.build }
	end

	def create
		@workout_type = current_user.workout_types.create(workout_type_params)

		if @workout_type.valid?
			redirect_to root_path
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def show
		@workout_type = WorkoutType.find(params[:id])
	end

	def edit
		@workout_type = WorkoutType.find(params[:id])

		if @workout_type.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end
	end

	def update
		@workout_type = WorkoutType.find(params[:id])

		if @workout_type.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end
		
		@workout_type.update_attributes(workout_type_params)
		
		if @workout_type.valid?
			redirect_to root_path
		else
			render :edit, :status => :unprocessable_entity
		end	
	end

	def destroy
    @workout_type = WorkoutType.find(params[:id])

    if @workout_type.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end
		
    @workout_type.destroy
    redirect_to root_path
  end

	def workout_type_params
		params.require(:workout_type).permit(:type_name, :public, exercise_types_attributes: [:name, :sets, :reps, :load])
	end

	def exercise_params
		params.require(:exercise).permit(:name, :sets, :reps, :load)
	end

end
