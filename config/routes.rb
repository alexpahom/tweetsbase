Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/users'            => 'users#index'
  # get '/users/new'        => 'users#new'
  # get '/users/:id/edit'   => 'users#edit', as: :edit_user
  # get '/users/:id'        => 'users#show', as: :user
  # post '/users'           => 'users#create'
  # patch '/users/:id'      => 'users#update'
  # delete '/users/:id'     => 'users#destroy'

  root 'messages#recent'
  get '/messages'           => 'messages#recent'
  resources :users do
    resources :messages
    # get '/messages'           => 'messages#index'
    # get '/messages/new'       => 'messages#new'
    # get '/messages/:id/edit'  => 'messages#edit'
    # get '/messages/:id'       => 'messages#show'
    # post '/messages'          => 'messages#create'
    # patch '/messages/:id'     => 'messages#update'
    # delete '/messages/:id'    => 'messages#destroy'
  end
end
