class Set < ActiveRecord::Base
	belongs_to :exercise
	attr_accessor :set_id, :exercise_id
end