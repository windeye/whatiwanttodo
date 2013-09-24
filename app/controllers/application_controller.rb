class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	def redirect_unless_admin
		unless current_user.admin?
			redirect_to root_url, :notice => 'you need to be an admin to do that'
			return
		end
	end
end
