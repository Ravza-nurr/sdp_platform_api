class Report < ApplicationRecord
  # İlişkiler
  belongs_to :analysis
  belongs_to :user

  # Format ve Durum tanımlamaları
  enum :format, { pdf: 0, docx: 1, html: 2 }
  enum :status, { generating: 0, ready: 1, error: 2 }

  # Doğrulamalar
  validates :analysis_id, presence: true
  validates :user_id, presence: true
  validates :format, presence: true
  validates :status, presence: true
end
