Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root    'sessions#new'
  get     '/messages',        to: 'messages#recent'
  get     '/signup',          to: 'users#new'
  get     '/login',           to: 'sessions#new'
  post    '/login',           to: 'sessions#create'
  delete  '/logout',          to: 'sessions#destroy'
  resources :users do
    resources :messages
  end
  resources :activations, only: [:edit]
  resources :resets, only: %i(new create edit update)
end
