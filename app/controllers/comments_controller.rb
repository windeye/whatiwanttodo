class CommentsController < ApplicationController
	before_filter :authenticate_user!
  def create
		@commentable = Comment.find_commentable(params[:comment][:commentable_type], params[:comment][:commentable_id])
		if @commentable
			@comment = @commentable.comments.build(comment_params)
			@comment.user = current_user
			authorize! :create, @comment
			if @comment.save
				render partial: "comments/comment", locals: { comment: @comment }, layout: false, status: :created
				#redirect_to powerpoint_path(@commentable), :notice => "Thanks for the comment."
			else
				#render :js => "alert('评论出错啦');"
				errors = []
        @comment.errors.messages.values.each do |msg|
          msg.each do |m|
						errors.append(m)
					end
				end
				render status: :bad_request, text: errors.join(','), layout: false
			end
		else
				render status: :bad_request, text: "", layout: false
		end
  end

	def destroy
		@comment = Comment.find(params[:id])
		authorize! :destroy, @comment
		if @comment.destroy
			render json: @comment, :status => :ok
		else
			render js: "alert('删除出错啦！');"
		end
	end

	private 

	def comment_params
    params.require(:comment).permit(:comment, :commentable_id, :commentable_type)
	end
end
