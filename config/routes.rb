TheShelf::Application.routes.draw do
  root 'books#index'

  resources :books
end
