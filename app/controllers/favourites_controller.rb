class FavouritesController < ApplicationController
	respond_to :html, :json 
  before_action :authenticate_user!

  def create
    @favourite = current_user.favourites.new(favourite_params)
    #authorize! :create, @favourite
    if @favourite.save!
			respond_with @favourite do |f|
			  f.html { render :partial => "favourites/favourite", :locals => { powerpoint: @favourite.powerpoint }, :layout => false }
			end
    else
			respond_with @favourite, status: :unprocessable_entity do |f|
			  f.html { render :partial => "favourites/favourite", :locals => { powerpoint: @favourite.powerpoint }, :layout => false }
			end
    end
  end

  def destroy
    @favourite = current_user.favourites.find(params[:id])
    @powerpoint = @favourite.powerpoint 
    authorize! :destroy, @favourite 
    if @favourite.destroy!
      respond_with @favourite do |f|
			  f.html { render :partial => "favourites/favourite", :locals => { powerpoint: @powerpoint }, :layout => false }
      end
    else
      respond_with @favourite, status: :bad_request do |f|
			  f.html { render :partial => "favourites/favourite", :locals => { powerpoint: @powerpoint }, :layout => false }
      end
    end
  end

  private
  def favourite_params
    params.permit(:powerpoint_id)
  end
end
