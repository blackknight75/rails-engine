Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      namespace :invoices do
        get '/find_all',          to: 'search#index'
        get 'find',               to: 'search#show'
        get 'random',             to: 'random#show'
        get '/:id/transactions',  to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items',         to: 'items#index'
        get '/:id/customer',      to: 'customer#show'
        get '/:id/merchant',      to: 'merchant#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get '/find_all',          to: 'search#index'
        get 'find',               to: 'search#show'
        get 'random',             to: 'random#show'
        get '/:id/merchant',      to: 'merchant#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
      end
      resources :items, only: [:index, :show]

      namespace :invoice_items do
        get '/find_all',    to: 'search#index'
        get 'find',         to: 'search#show'
        get 'random',       to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item',    to: 'item#show'
      end
      resources :invoice_items, only: [:index, :show]


      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end
      resources :customers, only: [:index, :show]
    end
  end
end
