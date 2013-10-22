class PowerpointsController < ApplicationController
	respond_to :html
  before_action :set_powerpoint, only: [:show, :edit, :update, :destroy]

	before_filter :authenticate_user!, only: [:edit, :create, :update, :destroy]
  # GET /powerpoints
  # GET /powerpoints.json
  def index
    @powerpoints = Powerpoint.page(params[:page]).per(12)
  end

  def category
    @c = Category.find(params[:id])
    @powerpoints = @c.powerpoints.page(params[:page]).per(12)
    
    render :index 
  end
  # GET /powerpoints/1
  # GET /powerpoints/1.json
  def show
		@comments = @powerpoint.comments.order('created_at desc')
    @comment = @powerpoint.comments.build		
    @powerpoint.views.increment
		@hottest = Rails.cache.fetch('hottests', expires_in: 2.hours) do
			allhottest = Powerpoint.hottest
			if allhottest.length > 4
				allhottest.slice(0,4)
			else
				allhottest.slice(0,allhottest.length)
			end
		end
		@newest = Rails.cache.fetch('newests', expires_in: 2.hours) do
		  Powerpoint.newest.limit(4)
		end
		#不能缓存这个,和具体的slide相关的。
		@relative = Powerpoint.tagged_with(@powerpoint.tag_list, on: :tags, any: true).where.not(id: @powerpoint.id).limit(4) 
  end

  # GET /powerpoints/1/edit
  def edit
		authorize! :manage, @powerpoint
		respond_with @powerpoint
  end

  # POST /powerpoints
  # POST /powerpoints.json
  def create
    @powerpoint = current_user.powerpoints.build(powerpoint_params)
    authorize! :manage, @powerpoint 
		if @powerpoint.save
			flash[:notice] = "创建幻灯片成功!"
		else
			flash[:notice] = "创建幻灯片失败!"
		end
		redirect_to :back
  end

  # PATCH/PUT /powerpoints/1
  # PATCH/PUT /powerpoints/1.json
  def update
		#如果每个用户都能上传ppt的话这样获取@powerpoint比较好，其他action也是
		#@powerpoint = current_user.powerpoints.find(params[:id])
    authorize! :manage, @powerpoint 
    respond_to do |format|
      if @powerpoint.update(powerpoint_params)
        format.html { redirect_to @powerpoint, notice: '修改幻灯片成功' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', notice: "修改幻灯片失败" }
        format.json { render json: @powerpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /powerpoints/1
  # DELETE /powerpoints/1.json
  def destroy
		#@powerpoint = current_user.powerpoints.find(params[:id])
    authorize! :manage, @powerpoint 
    if @powerpoint.destroy
			flash[:notice] = "删除幻灯片成功"
			redirect_to root_url
		else
			flash[:alert] = "删除幻灯片失败"
			respond_with @powerpoint, status: :bad_request do |f|
			  f.html { redirect_to :back }
			end
    end
  end

	def tagged
		if params[:tag].present? 
			@powerpoints = Powerpoint.tagged_with(params[:tag]).page(params[:page]).per(12)
			render :index 
		else 
			redirect_to :back
		end  
	end

	def favourites
		@powerpoints = current_user.favourite_powerpoints.page(params[:page]).per(12)
		render :index
	end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_powerpoint
      @powerpoint = Powerpoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def powerpoint_params
      params.require(:powerpoint).permit( :title, :description, :pdffile, :category_id,
										  :tag_list, :download_url, :powerpoint_type)
    end
end
