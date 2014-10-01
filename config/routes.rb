require 'sidekiq/web'

Rails.application.routes.draw do

  resources :offers, except: %i[new show edit] do
    resource :publisher, only: :create
  end

  resources :categories, except: %i[new edit]
  resources :products, except: %i[new edit]

  resources :advertisers, only: %i[create show]
  resources :publishers, only: :show

  mount Sidekiq::Web => '/sidekiq'
end
