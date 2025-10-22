class Response < ApplicationRecord
  # İlişkiler
  belongs_to :survey
  # participant_id bu projede dışarıdan gelen bir kimlik olarak kabul edilir

  # Doğrulamalar
  validates :survey_id, presence: true
  validates :participant_id, presence: true
  validates :response_data, presence: true
  validates :is_complete, inclusion: { in: [ true, false ] }
end
