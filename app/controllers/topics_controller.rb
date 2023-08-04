class TopicsController < ApplicationController
    before_action :authenticate_user, except: [:index]
    def index
        @topics = Topic.all
        render json: @topics
    end

end