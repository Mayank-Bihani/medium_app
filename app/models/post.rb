class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :comments
    has_many :views
    belongs_to :topic, foreign_key: 'topics_id'

    has_many :saves, class_name: 'Save', dependent: :destroy
    has_many :saved_by_users, through: :saves, source: :user
end
