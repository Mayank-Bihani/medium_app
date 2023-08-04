class CommentsController < ApplicationController
    before_action :authenticate_user
  
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      head :no_content
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text, :post_id)
  end
end
