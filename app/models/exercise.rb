class Exercise < ActiveRecord::Base
	belongs_to :workout_type
	attr_accessor :workout_type_id


end
