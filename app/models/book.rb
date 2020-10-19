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
      @books = Book.where("title LIKE?", "#{content}")
    elsif how == 'forward'
      @books = Book.where("title LIKE?", "#{content}%")
    elsif how == 'backward'
      @books = Book.where("title LIKE?", "%#{content}")
    elsif how == 'partial'
      @books = Book.where("title LIKE?", "%#{content}%")
    end
  end
end
