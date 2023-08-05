class ProfilesController < ApplicationController
    before_action :authenticate_user, except: [:show]

    def show
        @user = User.find(params[:id])
        editable = (current_user && @user == current_user)
        render json: @user, meta: { editable: editable }
    end

    def edit
        @user = User.find(params[:id])
        render json: @user
    end
    
      def update
        @user = User.find(params[:id])
        if @user.update(profile_update_params)
          render json: @user, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      private
    
      def profile_params
        params.require(:user).permit(:name, :username, :email, :bio, :photo)
      end
      def profile_update_params
        params.require(:user).permit(:name, :username, :email, :bio, :photo)
      end
end
