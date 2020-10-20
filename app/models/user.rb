class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  def self.search(how,content)
    if how == 'match'
      User.where("name LIKE?", "#{content}")
    elsif how == 'forward'
      User.where("name LIKE?", "#{content}%")
    elsif how == 'backward'
      User.where("name LIKE?", "%#{content}")
    elsif how == 'partial'
      User.where("name LIKE?", "%#{content}%")
    end
  end
end
