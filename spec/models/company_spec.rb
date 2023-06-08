require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
