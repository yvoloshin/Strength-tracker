class WorkoutTypesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :remove]
	before_filter :prepare_units

	def index
		if params[:search]
      @workout_types = WorkoutType.search(params[:search]).where({is_visible: true}).order("created_at DESC")
    else
			@workout_types = WorkoutType.where({is_visible: true}).order("created_at DESC")
		end
	end

	def new
		@workout_type = WorkoutType.new
		@exercise_types = Array.new(10) { @workout_type.exercise_types.build }
		@exercise_types.each do |exercise_type|
			exercise_type.weight_unit_id = 1
		end
	end

	def create
		@workout_type = WorkoutType.create(workout_type_params.merge(:user => current_user))
		@exercise_types = @workout_type.exercise_types
		
		@exercise_types.each_with_index do |exercise_type, index|
			index = index.to_s
			unit = WeightUnit.find(params[:workout_type][:exercise_types_attributes][index][:weight_unit_id])
			exercise_type.update(weight_unit: unit)
		end

		if @workout_type.save
			redirect_to root_path
		else
			render :new, :status => :unprocessable_entity
		end

		@workout_type.update(:is_visible => true)
		
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

	def remove
    @workout_type = WorkoutType.find(params[:id])
    
    return render_not_found if @workout_type.blank?

    if @workout_type.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end

		WorkoutType.update(params[:id], :is_visible => false)

    redirect_to root_path
  end

  def clone
  	cloned_workout_type = WorkoutType.find(params[:id])
  	@workout_type = cloned_workout_type.dup

    cloned_workout_type.exercise_types.each do |exercise_type|
      @workout_type.exercise_types << exercise_type.dup
    end

    exercise_types = @workout_type.exercise_types

		exercise_types.each do |exercise_type|
			if exercise_type.name.blank?
				exercise_type.destroy
			end
		end
  end

	def workout_type_params
		params.require(:workout_type).permit(:type_name, :public, :description, :exercise_types_attributes => [:id, :name, :sets, :reps, :load, :url, :weight_unit_id])
	end

	# add the @weight_units = WeightUnit.All to the before action to make it available for all actions
	private

	def prepare_units
	  @weight_units = WeightUnit.all
	end

end
