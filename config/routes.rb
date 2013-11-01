TheShelf::Application.routes.draw do
  root 'books#index'

  resources :books, only: [:index, :show]
end
