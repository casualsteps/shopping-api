require 'sidekiq/web'

Rails.application.routes.draw do

  resources :offers, except: %i[new show edit] do
    resources :publishers, only: :update
  end

  resources :categories, except: %i[new edit]
  resources :products, except: %i[new edit]

  resources :advertisers, only: :show
  resources :publishers, only: :show

  mount Sidekiq::Web => '/sidekiq'
end
