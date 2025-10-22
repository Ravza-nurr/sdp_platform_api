class Scale < ApplicationRecord
  # İlişkiler
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :surveys

  # Durum tanımlamaları
  enum :status, { draft: 0, review: 1, published: 2, archived: 3 }

  # Doğrulamalar
  validates :title, presence: true
  validates :description, presence: true
  validates :creator_id, presence: true
  validates :total_items, presence: true, numericality: { greater_than: 0 }
  validates :usage_count, numericality: { greater_than_or_equal_to: 0 }
end
