# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  root to: 'events#index'

  namespace :admin, shallow: true do
    resources :events

    resources :moderation_events do
      member do
        post :decline
        post :approve
      end
    end
  end

  resources :events
end
