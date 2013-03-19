Feedback::Application.routes.draw do

  # Main page
  root :to => "welcome#index"
  get "index" => "welcome#index"
  
  # Session
  get "login" => "sessions#login"
  post "login" => "sessions#login"
  get "logout" => "sessions#logout"
  
  get "profile" => "sessions#profile"
  get "profile/:login" => "sessions#profile"

  get "my/options" => "sessions#options"
  post "my/options" => "sessions#options"

  get "faq" => "welcome#faq"
  get "about" => "welcome#about"

  get "register" => "users#new"
  post "register" => "users#create"

  post "search" => "sessions#search"

  post "users/create"
end