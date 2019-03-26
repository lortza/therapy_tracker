Rails.application.routes.draw do
  resources :physical_therapy_sessions
  devise_for :users
  root to: 'exercise_logs#index'

  resources :exercises
  resources :exercise_logs
  resources :pain_logs

  namespace :admin do
    resources :users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
