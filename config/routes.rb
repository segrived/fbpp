Feedback::Application.routes.draw do
  # Main page
  root :to => "welcome#index"

  # Сессии (логин, логаут, страница профиля)
  get "login" => "sessions#login"
  post "login" => "sessions#login"
  get "logout" => "sessions#logout"
  get "profile/(:login)" => "sessions#profile", :as => :profile
  delete "remove_account" => "sessions#remove"

  # Регистрация
  get "register" => "users#new"
  post "register" => "users#create"

  # Настройки аккаунта
  get "my/options" => "sessions#options"
  post "my/options" => "sessions#options"

  # Имзенение пароля
  get "my/change_password" => "sessions#change_password"
  put "my/change_password" => "sessions#change_password"

  # Создание аккаунта администратора
  get "create_admin" => "users#create_admin_account"
  post "create_admin" => "users#create_admin_account"
  
  get "feedback/:id" => "subscriptions#show", as: :subscriptions
  get "users/:filter/(:page)" => "users#list", :as => :users, :page => /\d+/
  post "subjects/subscribe/:id" => "subjects#subscribe", :as => :subject_subscribe

  # Комментарии
  get "lecturer/:lid/comments" => "sessions#lecturer_comments", :as => :lecturer_comments
  post "comments/add" => "comments#add", :as => :add_comment
  delete "comments/:comment_id/delete" => "comments#destroy", :as => :delete_comment
  post "comment/:comment_id/:type" => "comments#vote", :as => :comment_vote, constraints: { type: /upvote|downvote/ }

  # Основные статические страницы
  get "index" => "welcome#index"
  get "faq" => "welcome#faq"
  get "about" => "welcome#about"
  get "lambda" => "welcome#lambda"

  # Кафедры
  resources :departaments
  get "departaments/:id/lecturers" => "departaments#show_lecturers", :as => :departament_lecturers
  get "departaments/:id/subjects" => "departaments#show_subjects", :as => :departament_subjects
  resources :specialties
  resources :subjects

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

  # Админ-часть
  namespace :admin do
    put "users/ban/:id/*banned" => "users#ban"
    put "lecturers/set_confirmation_level" => "lecturers#set_confirmation_level"
  end

  namespace :api do
    get "get_key" => "api#get_key"
    get "profile" => "api#profile"
    get "received_messages" => "api#received_messages"
    get "get_users" => "api#get_users"
    get "get_received_comments" => "api#get_received_comments"
    get "users/get_all"
    get "users/get_user_by_id/:id" => "users#get_user_by_id"
    get "users/get_lecturer_by_id/:id" => "users#get_lecturer_by_id"
  end
end