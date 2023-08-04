class AddPostsController < ApplicationController

    def create
        @post = Post.new(post_params)
    
        if @post.save
          render json: @post, status: :created
        else
          render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      private
    
      def post_params
        params.require(:post).permit(:title, :topic, :post_text, :post_time, :post_author_id)
      end

end
