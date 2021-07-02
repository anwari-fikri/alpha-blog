Rails.application.routes.draw do
  root "pages#index"
  get "/pages", to: "pages#index"
  
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
