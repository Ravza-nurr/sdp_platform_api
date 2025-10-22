class CreditTransaction < ApplicationRecord
  # İlişkiler
  belongs_to :user

  # İşlem Tipi tanımlamaları
  enum transaction_type: { purchase: 0, usage: 1, bonus: 2 }
end
