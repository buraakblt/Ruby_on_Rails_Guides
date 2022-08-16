Rails.application.routes.draw do
  get 'welcome/index'
  get 'search', to: 'articles#search'
 
  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end