class User <ApplicationRecord
    has_many :posts

    has_many :follower_relationships, class_name: 'Follow', foreign_key: 'following_id'
    has_many :followers, through: :follower_relationships, source: :follower
  
     has_many :following_relationships, class_name: 'Follow', foreign_key: 'follower_id'
    has_many :following, through: :following_relationships, source: :following

end
