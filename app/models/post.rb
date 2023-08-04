class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :comments
    has_many :views
    belongs_to :topic, foreign_key: 'topics_id'
end
