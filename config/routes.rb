TheShelf::Application.routes.draw do

  root 'books#index'

  resources :session, controller: :sessions, only: [:create]
  resources :books do
    member do
      get 'borrow' => 'book_keeper#borrow'
      get 'return' => 'book_keeper#return'
      get 'extend' => 'book_keeper#extend'
      get 'review' => 'reviews#new'
      post 'review' => 'reviews#create'
    end
    collection do
      get 'import' => 'import#import'
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

  namespace 'api' do
    namespace 'v1' do
      get 'search' => 'search#search'
      patch 'rate' => 'ratings#rate'
      get 'average' => 'ratings#average'
    end
  end
end
