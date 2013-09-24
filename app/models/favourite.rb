class Favourite < ActiveRecord::Base
	belongs_to :powerpoint, counter_cache: true
	belongs_to :user, counter_cache: true
	validates :user_id, :powerpoint_id, presence: true

	after_create :adjust_powerpoint_score

	def adjust_powerpoint_score
	  powerpoint.increase_score(1)
	end
end
