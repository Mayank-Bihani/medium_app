class User <ApplicationRecord
    has_secure_password
    
    validates :email, presence: true
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    
    
    has_many :posts
    has_many :likes
    has_many :comments
    has_many :views

    has_many :follows, foreign_key: :follower_id, dependent: :destroy
    has_many :following_users, through: :follows, source: :following

    has_many :saves, class_name: 'Save', dependent: :destroy
    has_many :saved_posts, through: :saves, source: :post

end
