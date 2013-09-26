class UserController < ApplicationController
	def update
		if params[:user][:password].blank?
		  params[:user].delete("password")
		  params[:user].delete("password_confirmation")
		end

		@user = User.find(current_user.id)  

		if @user.update_attributes(user_params)  
			flash[:notice] = "更新帐号成功"
			# Sign in the user bypassing validation in case his password changed
			sign_in @user, :bypass => true
			redirect_to after_update_path_for(@user)
		else
			render 'edit'
		end  
	end

	protected
	def after_sign_up_path_for(resource)
		#if $gabba.present?
		#	$gabba.identify_user(cookies[:__utma], cookies[:__utmz])
		#	$gabba.event("users", "sign_up", "id", resource.id)
		#end 
		edit_user_registration_path
	end 

	def after_update_path_for(resource)
		edit_user_registration_path
	end 

	private
	def user_params
    params.require(:user).permit(:email, :username, :avatar, :password,
																 :password_confirmation,:terms_of_service)
	end
end