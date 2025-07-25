Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    collection do
      get :search
    end
  end
  
  resources :authors, only: [:show]
  
  get 'reports/top_books'
  get 'reports/yearly_stats'
  
  root 'books#index'
end