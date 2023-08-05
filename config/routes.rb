Rails.application.routes.draw do
  get '/posts/by_date', to: 'posts#posts_by_date' 
  resources :posts do
    collection do
      get :drafts
      get :my_posts
    end
  end

  resources :posts do
    member do
      put :publish
    end
  end

  post '/drafts', to: 'posts#create'
  
  resources :posts do
    resources :saves, only: [:create]
  end

  get '/saves', to: 'saves#index'
  delete '/saves/:id', to: 'saves#destroy'

  
  resources :profiles
  get '/posts/by_user/:user_username', to: 'posts#posts_by_user'
  
  resources :add_post, only: [:create]
  post '/register', to: 'registrations#create'
  post '/login', to: 'sessions#create'
  get '/search', to: 'search#search'

  resources :posts, only: [:index, :show] do
    resources :likes, only: [:create, :destroy]
  end

  resources :comments, only: [:create, :destroy]

  resources :follows, only: [:create, :destroy]

  resources :posts do
    resource :views, only: [:create]
  end

  get '/topics', to: 'topics#index'

  post '/subscriptions', to: 'subscriptions#create'
end
