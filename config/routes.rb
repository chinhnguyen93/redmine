Rails.application.routes.draw do

  get 'add_developers/new'

  get 'add_developers/create'

  get 'sessions/new'

  # root 'static_pages#home'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  # get 'signin', to: 'sessions#new'
  root 'sessions#new'

  post 'signin', to: 'sessions#create'

  delete 'signout', to: 'sessions#destroy'

  resources :users, only: [:update,:edit,:show,:index,:destroy]

  resources :account_activations, only: [:edit]

  resources :projects, only: [:update,:index,:destroy]
  get '/new', to: 'users#new'

  get '/project/:iid/edit', to: 'projects#edit'

  get '/users/:id/projects/new', to: 'projects#new'

  post '/users/:id/projects', to: 'projects#create'
  
  get '/users/:id/projects/:iid/new_issue', to: 'projects#new_issue'

  post '/users/:id/projects/:iid/create_issue', to: 'projects#create_issue'

  get '/users/:jd/projects/:id/show_issue_create/:iid', to: 'projects#show_issue_create'

  get '/users/:jd/projects/:id/edit_issue/:iid', to: 'projects#edit_issue'

  patch '/projects/:id/update_issue/:iid', to: 'projects#update_issue'

  get '/users/:id/projects/:iid/show_issue', to: 'projects#show_issue'

  delete '/projects/:id/delete_issue/:iid', to: 'projects#destroy_issue'

  get 'users/:id/projects/:iid', to: 'projects#show'

  default_url_options :host => "localhost:3000"

  get '/projects/:id/add_developers/new', to: 'add_developers#new'

  post '/projects/:id/add_developers', to: 'add_developers#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
