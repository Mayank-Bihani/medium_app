class SavesController < ApplicationController
    before_action :authenticate_user
  
    def create
      post = Post.find(params[:post_id])
      save = current_user.saves.build(post: post)
  
      if save.save
        render json: { message: 'Post saved successfully' }, status: :created
      else
        render json: { errors: save.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def index
        saved_posts = current_user.saved_posts
        render json: saved_posts
      end
    
  
    def destroy
      save = current_user.saves.find_by(post_id: params[:id])
      if save
        save.destroy
        head :no_content
      else
        render json: { error: 'Save not found' }, status: :not_found
      end
    end
  end