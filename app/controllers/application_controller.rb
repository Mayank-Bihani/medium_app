class ApplicationController < ActionController::API
    before_action :authenticate_user 

    private
  
    def authenticate_user
      token = request.headers['Authorization']&.split(' ')&.last
      secret_key = Rails.application.credentials.secret_key_base
  
      begin
        decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
        user_id = decoded_token[0]['user_id']
        @current_user = User.find(user_id)
      rescue JWT::ExpiredSignature
        render json: { error: 'Token has expired' }, status: :unauthorized
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  
    def current_user
      @current_user
    end
end
