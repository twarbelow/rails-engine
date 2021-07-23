Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # post "/api/v1/items", to: 'api/v1/items#create'
  namespace :api do
    namespace :v1 do
      get '/items/find', to: 'items#find'
      get '/merchants/find_all', to: 'merchants#find_all'
      get '/merchants/revenue/:id', to: 'revenue#total_for_merchant'

      resources :items, only: [:create, :update, :destroy, :show, :index] do
         get '/merchant', to: 'items/merchants#show'
      end

      resources :merchants, only: [:show] do
        get '/items', to: 'merchants/items#index'
      end
    end
  end
end
