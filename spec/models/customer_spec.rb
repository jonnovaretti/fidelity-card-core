require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
