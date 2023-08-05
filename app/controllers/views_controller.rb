class ViewsController < ApplicationController
  before_action :authenticate_user
  before_action :check_already_viewed, only: :create

  def create
      @post = Post.find(params[:post_id])
      @view = View.new(user: current_user, post: @post)

      if @view.save
        render json: { message: 'View recorded successfully' }, status: :created
      else
        render json: { error: 'Failed to record view' }, status: :unprocessable_entity
      end
    end
  
    private

  def check_already_viewed
    if user_already_viewed?(params[:post_id])
      render json: { error: 'User already viewed this post' }, status: :unprocessable_entity
    end
  end

  def user_already_viewed?(post_id)
    current_user.views.exists?(post_id: post_id)
  end

  end

