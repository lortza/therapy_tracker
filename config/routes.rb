# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'logs#index'

  namespace :admin do
    resources :users, only: [:index, :show]
  end

  resources :charts, only: [:index]
  resources :stats, only: [:index]

  resources :exercises
  resources :pain_log_quick_form_values, only: [:index, :new, :create, :edit, :update, :destroy]
  post '/create_pain_log_from_quick_form', to: 'pain_logs#create_from_quick_form'

  resources :pains, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :body_parts, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :logs, only: [:index]
  resources :exercise_logs
  resources :pain_logs
  resources :pt_session_logs do
    resources :exercise_logs, controller: 'pt_session_logs/exercise_logs', only: [:new, :create, :show, :edit, :update, :destroy]
  end

  resources :slit_logs
  post '/quick_log_create', to: 'slit_logs#quick_log_create'
end
