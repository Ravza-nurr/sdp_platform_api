class CreditTransaction < ApplicationRecord
  # İlişkiler
  belongs_to :user

  # İşlem Tipi tanımlamaları
  enum transaction_type: { purchase: 0, usage: 1, bonus: 2 }

  # Doğrulamalar
  validates :user_id, presence: true
  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :transaction_type, presence: true
  validates :balance_after, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
