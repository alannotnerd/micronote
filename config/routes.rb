Rails.application.routes.draw do
  root 'static_pages#home'
  get 'home' => 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'help' => 'static_pages#help'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :groups
  resources :projects
  resources :courses, only: [:new, :create, :show, :edit]

  get '/groups/:id/invitation' => 'groups#gen_invitation'
  post '/groups/invitation' => 'groups#proc_invitation'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
