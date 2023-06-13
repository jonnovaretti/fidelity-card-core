require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:company) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(%w[active completed cancelled expired]) }
  end

  describe 'validations' do
    it { should validate_presence_of(:max_score) }
    it { should validate_numericality_of(:score).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_numericality_of(:max_score).is_greater_than(subject.score).only_integer }
  end
end
