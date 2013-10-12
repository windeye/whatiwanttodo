class Powerpoint < ActiveRecord::Base
	include Redis::Objects

	acts_as_commentable
	acts_as_taggable_on :tags
  scope :by_join_date, -> { order("created_at DESC") }
	belongs_to :user
	belongs_to :category

	has_many :favourites, dependent: :destroy
	mount_uploader :attachment, PowerpointUploader
	mount_uploader :image,      ImageUploader

	validates :attachment, :presence => true
	validates :image,      :presence => true
	validates :title,      :presence => true
	validates :description,:presence => true

	#visit times
  counter :views

	after_create :update_newest

	def update_newest
	  Powerpoint.newest_list << id	
	end

	def rank #获得该对象的排名
		Powerpoint.rankings.rank(id)
	end

	def score #获得该对象的得分
		Powerpoint.rankings[id]
	end

	def increase_score(by = 3)
		Powerpoint.rankings.increment(id, by)
    created = DateTime.parse(created_at.to_s).to_time.to_i
		current = Time.now.to_i
		hour_diff = (current - created)/3600 #相当于给票数乘以10
		if hour_diff == 0
			hour_diff = 1
		end
		Powerpoint.scores[id] = 10*(Powerpoint.rankings[id]/hour_diff).round(5)
	end

	class << self
		#the 25th latest powerpoint
		def newest_list
			Redis::List.new('newest', :maxlength => 25)
		end

		#the powerpoints' sorted score list
		def rankings
			Redis::SortedSet.new('rankings')
		end

		def scores
			Redis::SortedSet.new('scores')
		end

		def hottest
			hottest_ids = Powerpoint.scores.revrange(0,15)
			nonsorted_hottests = Powerpoint.where(id: hottest_ids)
			sorted_hottests = hottest_ids.map { |id| nonsorted_hottests[id.to_i] }.compact
		end

		def newest
			newest_ids = self.newest_list.values
			newests = Powerpoint.where(id: newest_ids)
		end

		def adjust_scores_crontab
			ids = Powerpoint.scores.revrange(0,30)
            front_30s = Powerpoint.where(id: ids)
			front_30s.each do |p|
				#current_score = Powerpoint.scores[p.id]
				created_time = DateTime.parse(p.created_at.to_s).to_time.to_i
				current_time = Time.now.to_i
				hour_diff = (current_time - created_time)/3600
				if hour_diff == 0
					hour_diff = 1
			  end 
				Powerpoint.scores[p.id] = 10*(Powerpoint.rankings[p.id]/hour_diff).round(5)
		  end 
		end

  end
end
