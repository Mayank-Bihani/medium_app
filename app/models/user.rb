class User <ApplicationRecord
    has_secure_password
    
    validates :email, presence: true
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    
    
    has_many :posts
    has_many :likes
    has_many :comments
    has_many :views

    has_many :follower_relationships, class_name: 'Follow', foreign_key: 'following_id'
    has_many :followers, through: :follower_relationships, source: :follower
  
     has_many :following_relationships, class_name: 'Follow', foreign_key: 'follower_id'
    has_many :following, through: :following_relationships, source: :following

end
