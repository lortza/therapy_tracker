Rails.application.routes.draw do
  devise_for :users
  root to: 'log_entries#index'

  resources :log_entries

  namespace :admin do
    resources :users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
