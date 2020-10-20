class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	def self.search(how,content)
    if how == 'match'
      Book.where("title LIKE?", "#{content}")
    elsif how == 'forward'
      Book.where("title LIKE?", "#{content}%")
    elsif how == 'backward'
      Book.where("title LIKE?", "%#{content}")
    elsif how == 'partial'
      Book.where("title LIKE?", "%#{content}%")
    end
  end
end
