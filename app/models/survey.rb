class Survey < ApplicationRecord
  # İlişkiler
  belongs_to :scale
  belongs_to :user # Survey'i oluşturan kullanıcı
  has_many :responses
  has_many :analyses

  # Durum ve Dağıtım Modu tanımlamaları
  enum status: { setup: 0, active: 1, completed: 2, paused: 3 }
  enum distribution_mode: { public_link: 0, email_invite: 1 }
end
