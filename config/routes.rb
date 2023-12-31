Rails.application.routes.draw do
  resources :cars
  resources :mpesas
  resources :admins
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/customer/register', to:'customers#register'
  post '/customer/login', to:'customers#login'
  # First step in reseting password
  post '/customer/forgot_password', to:'customers#forgot_password_step_1'
  # Second and last step in reseting password
  post '/customer/forgot_password/token', to: 'customers#forgot_password_step_2'

  # Testing JWT token
  post "/customer/login/test", to: "customers#test_token"

  # Loggin in for admin
  post '/admin/login', to:'admins#login'

  # Car controller
  # Creating a new car
  post '/car/create', to:'cars#new_car'


  # For mpesa
  post "stkpush", to: "mpesas#stkpush"
  post 'stkquery', to: 'mpesas#stkquery'
end
