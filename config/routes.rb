Rails.application.routes.draw do
  resources :log_entries
  devise_for :users
  root to: 'cats#index'

  resources :cats

  namespace :admin do
    resources :users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
