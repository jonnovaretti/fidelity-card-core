class Card < ApplicationRecord
  belongs_to :customer
  belongs_to :company

  enum status: %w[active completed cancelled expired]

  validates :max_score, presence: true

  validates_numericality_of :score, greater_than_or_equal_to: 0, only_integer: true
  validates_numericality_of :max_score, greater_than: ->(card) { card.score }, only_integer: true
end
