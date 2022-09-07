# frozen_string_literal: true

Rails.application.routes.draw do
  root 'root#index'

  match "/404" => "errors#not_found", via: :all
  match "/500" => "errors#internal_server_error", via: :all
  
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

  resources :courses, only: [:index]
  resources :teachers, only: [:index]
  resources :yoga_sessions, only: [:index] do
    post 'add_to_cart', on: :member
    delete 'remove_from_cart', on: :member, action: 'remove_from_cart'
  end

  scope :bookings do
    post 'create', to: 'bookings#create', as: 'checkout_create'
    get 'cancel', to: 'bookings#cancel', as: 'checkout_cancel'
    get 'success', to: 'bookings#success', as: 'checkout_success'
  end

  post '/webhook' =>  'webhooks#create', as: 'webhook'
  resources :cart, only: [:index]
end
