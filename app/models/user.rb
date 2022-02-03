class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # "フォローする側"
  has_many :relationships, class_name: 'Relationship', foreign_key: :follwed_id, dependent: :destroy
  # "あるユーザーがフォローしている人全員をとってくる"
  has_many :followeds, through: :relationships, source: :follower
  # "フォローされる側"
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # "あるユーザーをフォローしてくれている人全員をとってくる"
  has_many :followers , through: :reverse_of_relationships, source: :follwed

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(followed_id: user.id).present?
  end
end
