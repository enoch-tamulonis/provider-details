Rails.application.routes.draw do
  resources :provider_details, only: [:index], path: "provider-details"
  resources :providers, only: [:new, :create, :index, :show]
  resource :modal, only: [:create], controller: 'modal'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "provider_details#index"
end
