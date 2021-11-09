# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'logs#index'

  resources :charts, only: [:index]
  resources :stats, only: [:index]

  resources :exercises
  resources :easy_buttons, only: [:index, :new, :create, :edit, :update, :destroy]
  post '/new_pain_log_from_easy_button', to: 'pain_logs#new_from_easy_button'

  resources :pains, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :body_parts, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :logs, only: [:index]
  resources :exercise_logs
  resources :pain_logs
  resources :pt_session_logs do
    resources :exercise_logs, controller: 'pt_session_logs/exercise_logs', only: [:new, :create, :show, :edit, :update, :destroy]
  end

  namespace :admin do
    resources :users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
