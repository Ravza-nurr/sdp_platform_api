class Analysis < ApplicationRecord
  # İlişkiler
  belongs_to :user
  belongs_to :survey
  has_one :report # Bire bir ilişki

  # Tip ve Durum tanımlamaları
  enum analysis_type: { descriptive: 0, factor_analysis: 1, reliability: 2 }
  enum status: { pending: 0, running: 1, completed: 2, failed: 3 }
end
