Portrait::Application.routes.draw do
  resources :sites do
    post 'api', on: :collection
  end

  resources :users


  get '/forgot_password'=>'users#forgot_password'
  post '/reset_password'=>'users#reset_password'
  post '/'=>'sites#api',  as: 'api'
  get  '/'=>'home#index', as: 'root'

end
