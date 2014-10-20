TheShelf::Application.routes.draw do
  scope module: :v1, constraints: ApiConstraint.new(version: 1) do
    resources :books
  end
end
