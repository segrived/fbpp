Feedback::Application.routes.draw do
  # Main page
  root :to => "welcome#index"
  get "index" => "welcome#index"
  # Session
  get "login" => "sessions#login"
  post "login" => "sessions#login"
  get "logout" => "sessions#logout"
  get "profile/(:login)" => "sessions#profile", :as => :profile
  get "my/options" => "sessions#options"
  post "my/options" => "sessions#options"
  get "my/change_password" => "sessions#change_password"
  put "my/change_password" => "sessions#change_password"
  post "my/set_user_locale" => "sessions#set_user_locale"

  # Регистрация
  get "register" => "users#new"
  post "register" => "users#create"

  get "faq" => "welcome#faq"
  get "about" => "welcome#about"
  
  get "message/new/:receiver_id" => "private_messages#new", :as => :message_new
  post "message/new/:receiver_id" => "private_messages#new"
  get "message/read/:message_id" => "private_messages#read"
  get "messages/inbox" => "private_messages#inbox"
  get "messages/outbox" => "private_messages#outbox"

  namespace :admin do
    root :to => "start#index"
    get "users/:filter/(:page)" => "users#list", :as => :users, :page => /[0-9]+/
    put "users/ban/:id/*banned" => "users#ban"
    put "lecturers/set_confirmation_level" => "lecturers#set_confirmation_level"
  end

  namespace :api do
    get "users/get_all"
    get "users/get_user_by_id/:id" => "users#get_user_by_id"
    get "users/get_lecturer_by_id/:id" => "users#get_lecturer_by_id"
  end
end