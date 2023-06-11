require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  let(:company) { create(:company) }

  let(:valid_attributes) { attributes_for(:customer) }
  let(:invalid_attributes) { attributes_for(:customer).except(:name) }

  before { login(company.user) }

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:customer, company: company)
      get company_customers_path(company_id: company.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      customer = create(:customer)
      get company_customer_path(company, customer)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_company_customer_path(company)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      customer = create(:customer)
      get edit_company_customer_path(company_id: company.id, id: customer.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Customer' do
        expect do
          post company_customers_path(company), params: { customer: valid_attributes }
        end.to change(Customer, :count).by(1)
      end

      it 'redirects to the created customer' do
        post company_customers_path(company), params: { customer: valid_attributes }
        expect(response).to redirect_to(company_customer_url(company_id: company.id, id: Customer.last.id))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Customer' do
        expect do
          post company_customers_path(company), params: { customer: invalid_attributes }
        end.to change(Customer, :count).by(0)
      end

      it "renders an unprocessable response (i.e. to display the 'new' template)" do
        post company_customers_path(company), params: { customer: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number }
      end

      it 'updates the requested customer' do
        customer = create(:customer)
        patch company_customer_url(company_id: company.id, id: customer), params: { customer: new_attributes }
        customer.reload
        expect(customer.name).to eq(new_attributes[:name])
        expect(customer.phone).to eq(new_attributes[:phone])
      end

      it 'redirects to the customer' do
        customer = create(:customer)
        patch company_customer_url(company_id: company.id, id: customer), params: { customer: new_attributes }
        customer.reload
        expect(response).to redirect_to(company_customer_url(company_id: company.id, id: customer))
      end
    end

    context 'with invalid parameters' do
      it "renders an unprocessable response (i.e. to display the 'edit' template)" do
        customer = create(:customer)
        patch company_customer_url(company_id: company.id, id: customer), params: { customer: invalid_attributes }
        expect(response).to redirect_to(company_customer_url(company_id: company.id, id: customer))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested customer' do
      customer = create(:customer)
      expect do
        delete company_customer_url(company_id: company.id, id: customer)
      end.to change(Customer, :count).by(-1)
    end

    it 'redirects to the customers list' do
      customer = create(:customer)
      delete company_customer_url(company_id: company.id, id: customer)
      expect(response).to redirect_to(company_customers_url(company))
    end
  end
end
