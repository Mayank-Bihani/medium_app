Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts
  resources :profile
  get '/posts/by_user/:user_username', to: 'posts#posts_by_user' #, as: 'posts_by_userar'
  get '/posts/by_date', to: 'posts#posts_by_date' #, as: 'posts_by_date'
  resources :add_post, only: [:create]
  post '/register', to: 'registrations#create'
  post '/login', to: 'sessions#create'

end
