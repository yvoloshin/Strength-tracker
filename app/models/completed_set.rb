class CompletedSet < ActiveRecord::Base
	belongs_to :exercise
	has_one :weight_unit
end
