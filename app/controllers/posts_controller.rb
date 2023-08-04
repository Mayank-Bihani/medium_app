class PostsController < ApplicationController
    def show
        # byebug
        @post= Post.find(params[:id])
        render json:@post
    end
    def index
        @posts=Post.all
        render json:@posts
    end

    def posts_by_user
        user_username = params[:user_username]
        # puts "hello"
        # Rails.logger.info("Received user_username: #{user_username}")

        @user = User.find_by(username: user_username)
        render json: @user
        if @user
          @posts = @user.posts
          render json: @posts
        else
          render json: { error: 'User not found' }, status: :not_found
        end
      end
    
      def posts_by_date
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        @posts = Post.where(post_time: start_date..end_date)
        render json: @posts
      end

    # def new

    # end

    # def create
    #     @post=Post.new(params.require(:post).permit(:title, :topic, :post_text))
    #     @post.save
    #     redirect_to @post
    # end
    # def edit
    #     @post = Post.find(params[:id])
    # end
    # def create 
    #     @post=Post.new(params.require(:post).permit(:title, :topic, :post_text))
    #     if @post.save
    #     end
    # end

    # def update
    #     @post=Post.find(params[:id])
    #     if @post.update(params.require(:post).permit(:title, :topic, :post_text))
    #         flash[:notice]= "Post was updated successfully ."
    #         redirect_to @post
    #     else
    #         render 'edit'
    #     end
    # end
    
    # def destroy
    #     @post = Post.find(params[:id])
    #     @post.destroy
    #     redirect_to posts_path
    # end
    
end
