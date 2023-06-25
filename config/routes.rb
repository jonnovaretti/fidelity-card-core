Rails.application.routes.draw do
  root to: 'home#index'
  resources :companies do
    resources :cards, only: %i[index]
    resources :customers do
      resources :cards
    end
  end
  devise_for :users
end
