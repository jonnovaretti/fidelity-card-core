class Company < ApplicationRecord
  belongs_to :user
  has_many :customers, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true
end
