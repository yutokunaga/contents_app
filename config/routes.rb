Rails.application.routes.draw do
  get 'users/index'

  get '/posts/index', to:'posts#index'

  get '/', to: 'home#top'
end
