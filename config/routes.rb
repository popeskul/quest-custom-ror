# frozen_string_literal: true

Rails.application.routes.draw do
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
