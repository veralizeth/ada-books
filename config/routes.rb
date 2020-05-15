# config/routes.rb
Rails.application.routes.draw do

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  #Show profile info / only visit this page if they are log in
  get "/users/current", to: "users#current", as: "current_user"

  get "users/login_form"
  get "users/login"
  # verb 'path', to: 'controller#action'

  root to: "books#index"

  resources :books
  resources :authors do
    resources :books, only: [:index, :new]
  end

  # # Routes that operate on the book collection
  # get '/books', to: 'books#index', as: 'books'
  # get '/books/new', to: 'books#new', as: 'new_book'
  # post '/books', to: 'books#create'

  # # Routes that operate on individual books
  # get '/books/:id', to: 'books#show', as: 'book'
  # get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  # patch '/books/:id', to: 'books#update'
  # delete '/books/:id', to: 'books#destroy'
end
