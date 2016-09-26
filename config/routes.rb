Portrait::Application.routes.draw do
  resources :sites do
    post 'api', on: :collection
  end

  resources :customers do
    member do
      post 'bill'
      post 'cancel'
    end
  end

  resources :users

  post '/'=>'sites#api',  as: 'api'
  get  '/'=>'home#index', as: 'root'
end
