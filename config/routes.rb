Feedback::Application.routes.draw do
  # Main page
  root :to => "welcome#index"
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
  
  get "users/:filter/(:page)" => "users#list", :as => :users, :page => /\d+/


  post "add_lecturer_comment" => "comments#add_lecturer_comment"

  # Регистрация
  get "register" => "users#new"
  post "register" => "users#create"

  get "index" => "welcome#index"
  get "faq" => "welcome#faq"
  get "about" => "welcome#about"

  resources :departaments
  get "departaments/:id/lecturers" => "departaments#show_lecturers", :as => :departament_lecturers

  resources :specialties

  # Личные сообщения
  get "message/new/(:login)" => "private_messages#new", :as => :message_new, :login => /[A-Za-z][\w\d]+/
  get "message/new/(:mid)" => "private_messages#new", :as => :message_new, :mid => /[\d]+/
  post "message/new/" => "private_messages#new"
  delete "message/:message_id/delete" => "private_messages#delete", :as => :message_delete
  get "inbox" => "private_messages#inbox"
  get "outbox" => "private_messages#outbox"
  get "message/:message_id" => "private_messages#read", :as => :read_message

  # AJAX ответы
  get "ajax/unread_messages_count" => "ajax#unread_messages_count"

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