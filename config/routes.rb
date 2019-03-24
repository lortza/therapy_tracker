Rails.application.routes.draw do
  devise_for :users
  root to: 'exercise_logs#index'

  resources :exercise_logs

  namespace :admin do
    resources :users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
