class PostsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  
  
  def show
        # byebug
        @post= Post.where(draft: false).find(params[:id])
        views_count = @post.views.count
        likes_count = @post.likes.count
        comments = @post.comments.includes(:user)
        if current_user
          user_liked = current_user.likes.find_by(post: @post).present?
          user_viewed = current_user.views.exists?(post_id: post_id)
        else
          user_liked=false
          user_viewed=false
        end

          render json:{post: @post ,likes_count: likes_count, comments: comments, views_count: views_count, user_liked: user_liked, user_viewed: user_viewed}#, methods: [:likes_count]
    end

    def drafts
      @drafts = current_user.posts.where(draft: true)
      render json: @drafts
    end

    def index
        @posts=Post.where(draft: false).all
        @posts = @posts.map { |post| post.as_json.merge(reading_time: calculate_reading_time(post)) }
        render json: @posts
    end

    def calculate_reading_time(post)
      content= post.post_text
      if content.present?
        word_count = post.post_text.split.size
        wpm = 200 # average reading speed
        minutes = (word_count / wpm).ceil
        return minutes
      else
        return '0'
      end
    end

    def likes_count
      @likes.count
    end

    def posts_by_user
        user_username = params[:user_username]
        # puts "hello"
        # Rails.logger.info("Received user_username: #{user_username}")

        @user = User.find_by(username: user_username)
        # render json: @user
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
        Rails.logger.info("Received start_date: #{start_date} & end_date: #{end_date}" )
        @posts = Post.where(created_at: start_date.beginning_of_day..end_date.end_of_day)

        render json: @posts
      end


      def create
        topic_name = params[:topic_name]
         
        # puts "Topic Name: #{topic_name}"
        @post = current_user.posts.build(post_params)
        @post.draft = params[:draft] || false
        # @post.topics_id = topic.id 
        topic = Topic.find_or_create_by(topic_name: topic_name)
        # puts "Created Topic: #{topic.inspect}"

        @post.topic=topic
        if @post.save
          
          # @post.update(topic: topic)
          render json: @post, status: :created
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      
      def update
        @post = current_user.posts.find(params[:id])
    
        if @post.update(post_partial_params)
          @post.update(draft: params[:draft])
          render json: @post
        else
          render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def publish
        @post = Post.find(params[:id])
        if @post.update(draft: false)
          render json: { message: 'Draft published successfully' }, status: :ok
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @post = current_user.posts.find(params[:id])
        @post.destroy
        head :no_content
      end
    
      private
    
      def post_params
        params.require(:post).permit(:title, :topic, :post_text, :views, :drafts)
      end

      def post_partial_params
        params.require(:post).permit(:title, :topic, :text, :drafts)
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
