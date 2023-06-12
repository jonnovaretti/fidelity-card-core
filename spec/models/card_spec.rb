require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:company) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(%w[active completed cancelled expired]) }
  end
end
