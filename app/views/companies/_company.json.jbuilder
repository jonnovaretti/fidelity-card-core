json.extract! company, :id, :name, :user_id, :description, :phone, :created_at, :updated_at
json.url company_url(company, format: :json)
