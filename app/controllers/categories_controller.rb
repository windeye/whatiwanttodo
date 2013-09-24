class CategoriesController < ApplicationController
  def index
		@categories = Category.all
  end

  def show
  end

  def create
    @category = Category.create(category_params)
		if @category.save
			flash[:notice] = "添加分类成功"
		else
      flash[:alert] = "添加分类失败"
		end
		redirect_to manage_url
  end

  def destroy
		@category = Category.find(params[:id])
		if @category.destroy
			flash[:notice] = "删除分类成功"
		else
			flash[:notice] = "删除分类失败"
		end
		redirect_to categories_url
  end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
	def category_params
		params.require(:category).permit( :name, :nickname )
	end
end
