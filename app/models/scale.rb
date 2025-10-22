class Scale < ApplicationRecord
  # İlişkiler
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :surveys

  # Durum tanımlamaları
  enum status: { draft: 0, review: 1, published: 2, archived: 3 }

  # JSONB alanları için doğrulama veya yöntemler buraya eklenebilir.
end
