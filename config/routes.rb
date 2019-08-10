Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :users, param: :username, only: [:create, :update, :show, :index] do
      resources :collection_items, path: "collection", only: [:create, :index, :update, :destroy]
    end

    resources :sessions, only: [:create]
    resources :books, only: [:index, :show, :create, :update]

    get 'search/books', to: 'search#book_search'
    get 'search/isbn', to: 'search#check_in_library'
  end
end
