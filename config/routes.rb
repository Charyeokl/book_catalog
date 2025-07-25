Rails.application.routes.draw do
  get "pages/about", to: "pages#about", as: "about"
  resources :books, only: [:index, :show] do
    collection do
      get :search
    end
  end
  resources :books, only: [:index, :show] do
    collection do
      get :search
    end
  end
  
  resources :authors, only: [:index, :show]
  
  resources :publishers, only: [:index, :show]
  
  resources :authors, only: [:show]
  
  get 'reports/top_books'
  get 'reports/yearly_stats'
  
  root 'books#index'
end