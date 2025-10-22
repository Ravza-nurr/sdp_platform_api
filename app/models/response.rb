class Response < ApplicationRecord
  # İlişkiler
  belongs_to :survey

  # Not: participant_id bu projede dışarıdan gelen bir kimlik olarak kabul edilir.
  # is_complete boolean alanının varsayılan değerini migrasyonda ayarlamak faydalı olabilir.
end
