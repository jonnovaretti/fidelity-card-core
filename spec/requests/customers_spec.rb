require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  let(:company) { create(:company) }

  let(:valid_attributes) { customer(attributes_for(:customer, company: company)) }
  let(:invalid_attributes) { customer(attributes_for(:customer, company: company).except(:name)) }

  before { login(company.user) }

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:customer, company: company)
      get company_customers
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      customer = create(:customer)
      get company_customer(company, customer)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_company_custoomer
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      customer = create(:customer)
      get edit_company_customer(company, customer)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Customer' do
        expect do
          post company_customers, params: { customer: valid_attributes }
        end.to change(Customer, :count).by(1)
      end

      it 'redirects to the created customer' do
        post company_customers, params: { customer: valid_attributes }
        expect(response).to redirect_to(customer_url(Customer.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Customer' do
        expect do
          post company_customers, params: { customer: invalid_attributes }
        end.to change(Customer, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post company_customers, params: { customer: invalid_attributes }
        expect(response).to be_successful
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
        patch company_customer_url(customer), params: { customer: new_attributes }
        customer.reload
        expect(customer.name).to eq(new_attributes[:name])
        expect(customer.phone).to eq(new_attributes[:phone])
      end

      it 'redirects to the customer' do
        customer = create(:customer)
        patch company_customer_url(customer), params: { customer: new_attributes }
        customer.reload
        expect(response).to redirect_to(company_customer_url(customer))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        customer = create(:customer)
        patch company_customer_url(customer), params: { customer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested customer' do
      customer = create(:customer)
      expect do
        delete company_customer_url(customer)
      end.to change(Customer, :count).by(-1)
    end

    it 'redirects to the customers list' do
      customer = create(:customer)
      delete company_customer_url(customer)
      expect(response).to redirect_to(customers_url)
    end
  end
end
