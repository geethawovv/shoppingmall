Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  devise_for :users
  resources :products do
    member do
      post :favourite
    end
  end
end
