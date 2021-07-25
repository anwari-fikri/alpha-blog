class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 5000 }
end
