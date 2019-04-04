class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, allow_nil: true
  validates :email, {presence: true, uniqueness: true}
  validates :name,  presence: true, length: { maximum: 50 }

  has_many :comments
  has_many :posts

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships




  def posts
    return Post.where(user_id: self.id)
  end

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

end

