Rails.application.routes.draw do

  resources :categories
resources :task

  get '/', to: "users#index", as: "sign_in"
  post '/sessions' => "sessions#create"
  get '/sign_up', to: 'users#new', as: 'new_users'
  post '/users' => "users#create"
  get '/dashboard' => "categories#index"

  get '/add_task/:category_id', to: 'task#new', as: 'add_task'
  post '/create_task/:category_id' => "task#create", as: 'create_task'
  get '/task/:id/edit', to: "task#edit", as: 'edit_category_task'

get '/tasks/:category_id', to: 'task#index', as: 'category_tasks'
get '/sign_out', to: 'sessions#destroy', as: :sign_out


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
