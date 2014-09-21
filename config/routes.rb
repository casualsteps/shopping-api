Rails.application.routes.draw do

  resources :offers, except: %i[new show edit destroy] do
    resource :publisher, only: :create
  end

  resources :categories, except: %i[new show edit]
  resources :products, except: %i[new show edit]

  resources :advertisers, only: :show
  resources :publishers, only: :show
end
