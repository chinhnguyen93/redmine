Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  get 'signin', to: 'sessions#new'

  post 'signin', to: 'sessions#create'

  delete 'signout', to: 'sessions#destroy'

  resources :users

  resources :account_activations, only: [:edit]

  resources :projects
  
  get '/projects/:id/new_issue', to: 'projects#new_issue'

  post '/projects/:id/create_issue', to: 'projects#create_issue'

  get '/projects/:id/show_issue_create/:id', to: 'projects#show_issue_create'

  get '/projects/:id/show_issue', to: 'projects#show_issue'

  default_url_options :host => "localhost:3000"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
