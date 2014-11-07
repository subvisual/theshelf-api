TheShelf::Application.routes.draw do
  scope module: :api do
    scope module: :v1, constraints: ApiConstraint.new(version: 1) do
      devise_for :users, skip: [:sessions]
      resources :books
      resources :users, only: [:create]
    end
  end
end
