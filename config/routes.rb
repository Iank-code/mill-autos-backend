Rails.application.routes.draw do
  resources :mpesas
  resources :admins
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/customer/register', to:'customers#register'
  post '/customer/login', to:'customers#login'

  # Testing JWT token
  post "/customer/login/test", to: "customers#test_token"

  # Loggin in for admin
  post '/admin/login', to:'admins#login'

  # For mpesa
  post "stkpush", to: "mpesas#stkpush"
  post 'stkquery', to: 'mpesas#stkquery'
end
