Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "meals#index"

  resources :meals, only: [:index, :new, :create, :update, :show, :destroy] do
    collection do
      get :meals_index
    end
    resources :foods, only: [:index, :new, :create, :show, :edit, :update]
  end

  get "/search", to: "foods#search"

  get "/dashboard", to: "pages#dashboard"
  get "/about", to: "pages#about"
  get "/favorite", to: "foods#favorite"
end
