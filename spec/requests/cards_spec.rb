require 'rails_helper'

RSpec.describe '/cards', type: :request do
  let(:company) { create(:company) }
  let(:customer) { create(:customer, company: company) }

  before do
    login(company.user)
  end

  let(:valid_attributes) do
    attributes_for(:card).merge(customer_id: customer.id, company_id: company.id)
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_company_customer_card_url(company, customer)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      card = create(:card)
      get edit_company_customer_card_url(company, customer, card)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Card' do
        expect do
          post company_customer_cards_path(company, customer), params: { card: valid_attributes }
        end.to change(Card, :count).by(1)
      end

      it 'redirects to the customer details' do
        post company_customer_cards_path(company, customer), params: { card: valid_attributes }
        expect(response).to redirect_to(company_customer_url(company, customer))
      end
    end

    context 'with invalid parameters' do
      before do
        allow_any_instance_of(Card).to receive(:save).and_return(false)
      end

      it 'does not create a new Card' do
        expect do
          post company_customer_cards_path(company, customer), params: { card: valid_attributes }
        end.to change(Card, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post company_customer_cards_path(company, customer), params: { card: valid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) do
      { score: 10 }
    end

    context 'with valid parameters' do
      it 'updates the requested card' do
        card = create(:card)
        patch company_customer_card_url(company, customer, card), params: { card: new_attributes }
        card.reload
        expect(card.score).to eq(10)
      end

      it 'redirects to the customer details' do
        card = create(:card)
        patch company_customer_card_url(company, customer, card), params: { card: new_attributes }
        card.reload
        expect(response).to redirect_to(company_customer_url(company, customer))
      end
    end

    context 'with invalid parameters' do
      before do
        allow_any_instance_of(Card).to receive(:save).and_return(false)
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        card = create(:card)
        patch company_customer_card_url(company, customer, card), params: { card: new_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'cancels the requested card' do
      card = create(:card, status: 'active')
      expect do
        delete company_customer_card_url(company, customer, card)
        card.reload
      end.to change(card, :status).from('active').to('cancelled')
    end

    it 'redirects to the customer details' do
      card = create(:card)
      delete company_customer_url(company, customer, card)
      expect(response).to redirect_to(company_customer_url(company, customer))
    end
  end
end
