Rails.application.routes.draw do
  resources :companies do
    resources :cards, only: %i[index]
    resources :customers do
      resources :cards
    end
  end
  devise_for :users
end
