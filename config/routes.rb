Rails.application.routes.draw do

  post 'users/perform_login'
  get 'users/welcome_page'
  get 'users/login_page'

  #post is to accept and store uploading, submitting file
  #get is to retrieve data no other effect

  resources :users
  resources :blogs

  # just instructing the http to show this page
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
