class Powerpoint < ActiveRecord::Base
	include Redis::Objects

	#mount_uploader :attachment, PowerpointUploader
	#mount_uploader :image,      ImageUploader
	#validates :attachment, :presence => true
	#validates :image,      :presence => true

  before_create :store_meta_info
	after_create :update_newest
  after_save :update_page_counts

  has_attached_file :pdffile,:url => "/uploads/:class/:attachment/:style/:filename",
                    :styles => { :images => { :params => "-r88",:format => "png" } },
                    :processors => [:pdf_imagize]

	acts_as_commentable
	acts_as_taggable_on :tags
  scope :by_join_date, -> { order("created_at DESC") }
	belongs_to :user
	belongs_to :category

	has_many :favourites, dependent: :destroy
	validates :title,      :presence => true
	validates_attachment :pdffile, :presence => true,
		  :content_type => { :content_type => "application/pdf" },
			:size => { :in => 0..15.megabytes}
	#validates :description,:presence => true

	#visit times
  counter :views

	def update_newest
	  Powerpoint.newest_list << id	
	end

	def store_meta_info
		#@current_format = File.extname(avatar_file_name)
		#@basename       = File.basename(avatar_file_name, @current_format)
		self.file_id =  Digest::SHA1.hexdigest(pdffile_file_name.delete("_ "))
		self.pdffile.instance_write(:file_name, "#{self.file_id}_#{pdffile_file_name}")
	end

	def update_page_counts
		StoreMetaWorker.perform_async(id)
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
