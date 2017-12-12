Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/users'            => 'users#index'
  get '/users/new'        => 'users#new'
  get '/users/:id/edit'   => 'users#edit', as: :edit_user

end
