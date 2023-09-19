require "sidekiq/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'health_check', to: 'health#index'
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web, at: '/sidekiq'  

  namespace :v1 do
    resources :sign_up, only: [:create]

    resources :auth, only: [:create] do
      collection do
        get     :show,      as: :me
        put     :update,    as: :refresh
        delete  :destroy,   as: :logout
      end
    end

    resources :links, only: [:index, :create]
  end
end
