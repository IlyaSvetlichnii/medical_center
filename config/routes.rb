require 'api_constraints'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'users#index'

  resources :users
  # resources :session

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  put 'add_patient', to: 'users#add_patient'
  get 'patient_registration', to: 'users#patient_registration'
  get 'patients', to: 'users#patients'

  namespace 'api' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      post 'signup', to: 'users#create'
      post 'login', to: 'sessions#create'
      post 'logout', to: 'sessions#destroy'
    end
  end
end
