class User < ApplicationRecord
  # 1. has_secure_password
  has_secure_password

  # 2. enum tanımını basit, tek satırda tutuyoruz.
  enum role: { admin: 0, researcher: 1, participant: 2 }

  # İlişkiler
  has_many :scales, foreign_key: :creator_id
  has_many :surveys
  has_many :analyses
  has_many :credit_transactions
  has_many :reports
  has_many :responses, through: :surveys

  # Doğrulamalar
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
end
