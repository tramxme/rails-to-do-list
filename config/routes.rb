ToDoList::Application.routes.draw do
  root :to => "welcome#index"
  get "/users/dashboard" => 'users#dashboard'
  get "/users/profile" => "users#profile"

  devise_for :users
  resources :users
  resources :items

  
end
