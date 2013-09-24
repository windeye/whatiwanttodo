class HomeController < ApplicationController
  def index
		@user = current_user if signed_in?
		#@powerpoints = current_user.powerpoints if signed_in?
		#@categories = Category.all
  end

	def leokmaxloveemilyforever
		@categories = Category.all
		@powerpoint = current_user.powerpoints.build if signed_in?
		@category = Category.new
		#render layout: false
	end
end
