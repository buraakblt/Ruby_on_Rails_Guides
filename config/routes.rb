Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/u/:id', to: 'users#profile', as: 'user'
  get 'welcome/index'
  get 'search', to: 'articles#search'
 
  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end