TheShelf::Application.routes.draw do

  root 'books#index'

  resources :session, controller: :sessions, only: [:create]
  resources :books do
    member do
      get 'borrow'
      patch 'rate'
      get 'average'
      get 'return'
      get 'review' => 'books#new_review', as: 'new_review'
      post 'review' => 'books#create_review', as: 'create_review'
    end
    collection do
      get 'search'
    end
  end

  scope :my_account do
    get '/' => 'users#edit', as: 'my_account'
    patch '/' => 'users#update', as: 'update_my_account'
  end

  get '/log_in' => 'sessions#new', :as => 'log_in'
  delete '/log_out' => 'sessions#destroy', :as => 'log_out'

  get '/sign_up' => 'users#new', :as => nil
  post '/users' => 'users#create', :as => nil
end
