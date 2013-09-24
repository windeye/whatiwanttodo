class Category < ActiveRecord::Base
	validates :name, :nickname, presence: true
	validates :name, :nickname, uniqueness: true
	has_many :powerpoints
end
