Rails.application.routes.draw do
  namespace :v1, defaults: {format: :json } do
    resources :users, param: :username, only: [:create, :update, :show, :index]
    resources :sessions, only: [:create]
    resources :books, only: [:index, :create]
    get 'search/books', to: "search#book_search"
  end
end
