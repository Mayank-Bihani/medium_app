class LikesController < ApplicationController
    before_action :authenticate_user

    def create
      post = Post.find(params[:post_id])
      if current_user.likes.find_by(post: post)
        render json: { error: 'Post already liked by the user' }, status: :unprocessable_entity
      else
        like = current_user.likes.create(post: post)
        render json: { message: 'Post liked' }
      end
    end
  
    def destroy
        post = Post.find(params[:post_id])
        like = current_user.likes.find_by(post: post)
    
        if like
          like.destroy
          render json: { message: 'Post unliked' }
        else
          render json: { error: 'Like not found' }, status: :not_found
        end
      end
end
