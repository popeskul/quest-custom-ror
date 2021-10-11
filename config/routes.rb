# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  root to: 'events#index'

  namespace :admin do
    resources :events
  end

  resources :events
end
