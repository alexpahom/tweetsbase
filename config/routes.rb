Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/users'            => 'users#index'
  # get '/users/new'        => 'users#new'
  # get '/users/:id/edit'   => 'users#edit', as: :edit_user
  # get '/users/:id'        => 'users#show', as: :user
  # post '/users'           => 'users#create'
  # patch '/users/:id'      => 'users#update'
  # delete '/users/:id'     => 'users#destroy'

  root 'users#index'
  resources :users
end
