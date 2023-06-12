class Card < ApplicationRecord
  belongs_to :customer
  belongs_to :company
  enum status: %w[active completed cancelled expired]
end
