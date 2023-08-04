class FollowsController < ApplicationController
    before_action :authenticate_user

  def create
    followeing_user = User.find(params[:following_id])
    follow = current_user.following_users.build(following: following_user)

    if follow.save
      render json: { message: 'User followed successfully' }, status: :created
    else
      render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    follow = current_user.following_users.find_by(following_id: params[:id])
    if follow
      follow.destroy
      head :no_content
    else
      render json: { error: 'Follow not found' }, status: :not_found
    end
  end
end
