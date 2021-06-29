class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 5000 }
end
