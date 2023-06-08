Rails.application.routes.draw do
  resources :companies
  devise_for :users

  root 'users#index'
end
