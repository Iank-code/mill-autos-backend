Rails.application.routes.draw do
  resources :mpesas
  resources :admins
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/customer/register', to:'customers#register'
  post '/customer/login', to:'customers#login'

  # Loggin in for admin
  post '/admin/login', to:'admins#login'
end
