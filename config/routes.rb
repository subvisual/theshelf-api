TheShelf::Application.routes.draw do
  devise_for :users

  scope module: :v1, constraints: ApiConstraint.new(version: 1) do
    resources :books
  end
end
