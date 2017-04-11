Rails.application.routes.draw do

  get 'add_developers/new'

  get 'add_developers/create'

  get 'sessions/new'

  # root 'static_pages#home'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  # get 'signin', to: 'sessions#new'
  root "users#current_user_"

  post 'signin', to: 'sessions#create'

  delete 'signout', to: 'sessions#destroy'

  resources :users, only: [:update,:edit,:show,:index,:destroy]

  resources :account_activations, only: [:edit]

  resources :projects, only: [:index,:destroy]
  get '/new', to: 'users#new'

  get '/projects/:iid/edit', to: 'projects#edit'

  patch '/projects/:iid', to: 'projects#update'

  get '/users/:id/projects/new', to: 'projects#new'

  post '/users/:id/projects', to: 'projects#create'
  
  get '/projects/:iid/new_issue', to: 'projects#new_issue'

  get '/projects/:iid/show_issue', to: 'projects#show_issue'

  post '/projects/:iid/create_issue', to: 'projects#create_issue'

  get '/projects/:iid/show_issue_create/:id', to: 'projects#show_issue_create'

  get '/projects/:iid/edit_issue/:id', to: 'projects#edit_issue'

  patch '/projects/:iid/update_issue/:id', to: 'projects#update_issue'

  delete '/projects/:iid/delete_issue/:id', to: 'projects#destroy_issue'

  get '/projects/:iid', to: 'projects#show'

  default_url_options :host => "localhost:3000"

  get '/projects/:id/add_developers/new', to: 'add_developers#new'

  post '/projects/:id/add_developers', to: 'add_developers#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
