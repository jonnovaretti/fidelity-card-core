Rails.application.routes.draw do

  resources :companies do
    resources :customers
  end
  devise_for :users
end
