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

  get "create_admin" => "users#create_admin_account"
  post "create_admin" => "users#create_admin_account"
  
  get "users/:filter/(:page)" => "users#list", :as => :users, :page => /[0-9]+/


  # Регистрация
  get "register" => "users#new"
  post "register" => "users#create"

  get "faq" => "welcome#faq"
  get "about" => "welcome#about"
  get "departaments" => "departaments#list"
  get "departament/:id" => "departaments#info", :as => :departament
  get "departament/:id/lecturers" => "departaments#lecturers", :as => :departament_lecturers

  # Приватные сообщения
  get "message/new/(:login)" => "private_messages#new", :as => :message_new
  post "message/new/" => "private_messages#new"

  get "message/read/:message_id" => "private_messages#read"

  get "inbox" => "private_messages#inbox"
  get "outbox" => "private_messages#outbox"

  # json responses
  get "unread_messages_count" => "sessions#unread_messages_count"

  namespace :admin do
    put "users/ban/:id/*banned" => "users#ban"
    put "lecturers/set_confirmation_level" => "lecturers#set_confirmation_level"
  end

  namespace :api do
    get "users/get_all"
    get "users/get_user_by_id/:id" => "users#get_user_by_id"
    get "users/get_lecturer_by_id/:id" => "users#get_lecturer_by_id"
  end
end