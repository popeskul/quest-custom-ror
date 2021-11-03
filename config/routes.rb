# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :staff do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }
  devise_for :staffs, path_names: { sign_in: :login, sign_out: :logout }

  root to: 'events#index'

  namespace :admin, shallow: true do
    resources :events

    resources :staffs

    resources :tags

    resources :moderation_events do
      member do
        post :decline
        post :approve
      end
    end
  end

  resources :events
end
