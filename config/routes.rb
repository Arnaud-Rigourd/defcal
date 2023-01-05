Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "meals#index"

  resources :meals, only: [:index, :create, :update] do
    resources :foods, only: [:index, :new, :create, :show, :edit, :update]
  end

  get "/search", to: "foods#search"
end
