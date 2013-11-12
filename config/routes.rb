TheShelf::Application.routes.draw do

  root 'books#index'

  resources :users, controller: :users, only: [:create]
  resources :books

end
