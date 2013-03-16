Feedback::Application.routes.draw do

  # Main page
  root :to => "welcome#index"
  get "index" => "welcome#index"
  get "my" => "welcome#index"
  
  # Session
  get "login" => "sessions#login"
  post "login" => "sessions#login"
  get "logout" => "sessions#logout"
  get "profile" => "sessions#profile"

  get "register" => "users#new"
  post "users/create"
  get "welcome/index"

  get "sessions/profile"
  get "users/new"
end