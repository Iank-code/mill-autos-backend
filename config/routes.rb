Rails.application.routes.draw do
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/customer/register', to:'customers#register'
  post '/customer/login', to:'customers#login'
end
