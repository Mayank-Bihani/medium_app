class SearchController < ApplicationController
    def search
        search_text = params[:search_text]
        
        users = User.where('username LIKE ?', "%#{search_text}%")
        posts = Post.where('title LIKE ?', "%#{search_text}%")
        topics = Topic.where('topic_name LIKE ?', "%#{search_text}%")
        
        render json: { users: users, posts: posts, topics: topics }
      end
end
