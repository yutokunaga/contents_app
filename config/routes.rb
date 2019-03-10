Rails.application.routes.draw do
  post 'likes/:post_id/create', to: 'likes#create'
  post 'likes/:post_id/destroy', to: 'likes#destroy'

  post 'users/:id/update', to:'users#update'
  post 'users/:id/edit', to:'users#edit'
  post 'users/create', to:'users#create'
  get 'signup', to:'users#signup'
  get 'users/index', to:'users#index'
  get 'users/:id', to:'users#show'
  post 'login', to:'users#login'
  post 'logout', to:'users#logout'
  get 'login', to:'users#login_form'
  get 'users/:id/likes', to:'users#likes'

  get 'posts/index', to:'posts#index'
  get 'posts/new', to:'posts#new'
  get 'posts/:id', to:'posts#show'
  post 'posts/create', to:'posts#create'
  post 'posts/comment', to:'posts#comment'
  get 'posts/:id/edit', to:'posts#edit'
  get 'posts/:id/update', to:'posts#update'
  get 'posts/:id/destroy', to:'posts#destroy'



  get '/', to: 'home#top'
end
