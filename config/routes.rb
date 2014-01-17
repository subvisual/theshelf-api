TheShelf::Application.routes.draw do

  root 'books#index'

  resources :session, controller: :sessions, only: [:create]
  resources :users, controller: :users, only: [:create]
  resources :books do
    member do
      get 'borrow'
      get 'return'
      get 'review' => 'books#new_review', as: 'new_review'
      post 'review' => 'books#create_review', as: 'create_review'
    end
  end

  get '/log_in' => 'sessions#new', :as => 'log_in'
  delete '/log_out' => 'sessions#destroy', :as => 'log_out'
end
