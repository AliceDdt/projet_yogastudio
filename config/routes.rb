# frozen_string_literal: true

Rails.application.routes.draw do
  root 'root#index'
  
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'clearance/users', only: [:show, :create, :edit, :update] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:edit, :update]
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'clearance/users#new', as: 'sign_up'

  # resource :me, controller: 'me', only: %i[show edit update]

  resources :courses, only: [:index]
  resources :teachers, only: [:index]
  resources :yoga_sessions, only: [:index] do
    post 'add_to_cart', on: :member, action: 'add_to_cart'
    delete 'remove_from_cart', on: :member, action: 'remove_from_cart'
  end

  scope :bookings do
    post 'create', to: 'bookings#create', as: 'checkout_create'
    get 'cancel', to: 'bookings#cancel', as: 'checkout_cancel'
    get 'success', to: 'bookings#success', as: 'checkout_success'
  end

  # resources :bookings, only: [:create] do
  #   post 'create', to: 'bookings#create', as: ' '
  #   get 'success', to: 'checkout#success', as: 'checkout_success'
  # end

  resources :cart, only: [:index]
end
