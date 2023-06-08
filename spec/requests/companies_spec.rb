require 'rails_helper'

RSpec.describe CompaniesController, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:company, user: user) }
  let(:invalid_attributes) { attributes_for(:company).except(:name) }

  before {
    login(user)
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      get companies_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      company = create(:company, user: user)
      get company_url(company)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_company_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      company = create(:company, user: user)
      get edit_company_url(company)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Company' do
        expect do
          post companies_url, params: { company: valid_attributes }
        end.to change(Company, :count).by(1)
      end

      it 'redirects to the created company' do
        post companies_url, params: { company: valid_attributes }
        expect(response).to redirect_to(company_url(Company.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Company' do
        expect do
          post companies_url, params: { company: invalid_attributes }
        end.to change(Company, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post companies_url, params: { company: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Changed Company' }
      end

      it 'updates the requested company' do
        company = create(:company, user: user)
        patch company_url(company), params: { company: new_attributes }
        company.reload
        expect(company.name).to eq('Changed Company')
      end

      it 'redirects to the company' do
        company = create(:company, user: user)
        patch company_url(company), params: { company: new_attributes }
        company.reload
        expect(response).to redirect_to(company_url(company))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        company = create(:company, user: user)
        patch company_url(company), params: { company: invalid_attributes }
        expect(response).to redirect_to(company_url(company))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested company' do
      company = create(:company, user: user)
      expect do
        delete company_url(company)
      end.to change(Company, :count).by(-1)
    end

    it 'redirects to the companies list' do
      company = create(:company, user: user)
      delete company_url(company)
      expect(response).to redirect_to(companies_url)
    end
  end
end
