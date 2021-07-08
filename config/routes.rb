Rails.application.routes.draw do
  root "pages#index"
  get "signup", to: "users#new"
  
  resources :users, except: [:new]
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
