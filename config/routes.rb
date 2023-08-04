Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/posts/by_date', to: 'posts#posts_by_date' #, as: 'posts_by_date'
  resources :posts
  resources :profile
  get '/posts/by_user/:user_username', to: 'posts#posts_by_user' #, as: 'posts_by_userar'
  
  resources :add_post, only: [:create]
  post '/register', to: 'registrations#create'
  post '/login', to: 'sessions#create'
  get '/search', to: 'search#search'

  resources :posts, only: [:index, :show] do
    resources :likes, only: [:create, :destroy]
  end
  resources :comments, only: [:create, :destroy]

  post 'follows', to: 'follows#create'
  delete 'follows/:id', to: 'follows#destroy'

  resources :posts do
    resource :views, only: [:create]
  end
  get '/topics', to: 'topics#index'
end
