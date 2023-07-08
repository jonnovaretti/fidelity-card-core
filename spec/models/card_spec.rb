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

  describe '#update_score' do
    context 'when card is active' do
      let(:card) { create(:card, max_score: 10) }

      it 'updates score' do
        expect do
          card.update_score(10)
        end.to change(card, :score).from(0).to(10)
      end

      it 'updates status' do
        expect do
          card.update_score(10)
        end.to change(card, :status).from('active').to('completed')
      end
    end

    [:completed, :cancelled, :expired].each do |status|
      context "when card is not #{status}" do
        let(:card) { create(:card, max_score: 10, status: status) }

        it 'updates score' do
          expect do
            card.update_score(10)
          end.to_not change(card, :score)
        end

        it 'updates status' do
          expect do
            card.update_score(10)
          end.to_not change(card, :status)
        end
      end
    end
  end
end
