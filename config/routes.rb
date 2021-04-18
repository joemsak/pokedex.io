Rails.application.routes.draw do
  namespace :user do
    resource :dashboard, only: :show
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'login', to: 'sessions#new', as: :login
  get 'log_in', to: 'sessions#new', as: :log_in
  get 'signin', to: 'sessions#new', as: :signin
  get 'sign_in', to: 'sessions#new', as: :sign_in

  get 'signup', to: 'users#new', as: :signup
  get 'sign_up', to: 'users#new', as: :sign_up

  root to: "users#new"
end
