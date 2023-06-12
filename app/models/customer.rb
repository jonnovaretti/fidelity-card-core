class Customer < ApplicationRecord
  belongs_to :company
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true
end
