Feedback::Application.routes.draw do
  # Main page
  root :to => "welcome#index"
  get "index" => "welcome#index"
  # Session
  get "login" => "sessions#login"
  post "login" => "sessions#login"
  get "logout" => "sessions#logout"
  get "profile/(:login)" => "sessions#profile"
  get "my/options" => "sessions#options"
  post "my/options" => "sessions#options"
  post "my/set_user_locale" => "sessions#set_user_locale"

  # Регистрация
  get "register" => "users#new"
  post "register" => "users#create"

  get "faq" => "welcome#faq"
  get "about" => "welcome#about"
  

  namespace :admin do
    root :to => "start#index"
    get "users/(:page)" => "users#list", :as => :users
    put "users/ban/:id/*banned" => "users#ban"
  end
end