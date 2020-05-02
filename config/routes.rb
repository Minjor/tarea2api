Rails.application.routes.draw do
  resources :hamburguesa_ingredientes
  resources :ingredientes
  resources :hamburguesas
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/hamburguesa', to: 'hamburguesas#index'
  get '/hamburguesa/:id', to: 'hamburguesas#show'
  post '/hamburguesa', to: 'hamburguesas#create'
  delete '/hamburguesa/:id', to: 'hamburguesas#destroy'
  patch '/hamburguesa/:id', to: 'hamburguesas#update'

  get '/ingrediente', to: 'ingredientes#index'
  get '/ingrediente/:id', to: 'ingredientes#show'
  post '/ingrediente', to: 'ingredientes#create'
  delete '/ingrediente/:id', to: 'ingredientes#destroy'
  patch '/ingrediente/:id', to: 'ingredientes#update'

  put '/hamburguesa/:hid/ingrediente/:iid', to: 'hamburguesa_ingredientes#addingredient'
  delete '/hamburguesa/:hid/ingrediente/:iid', to: 'hamburguesa_ingredientes#deleteingredient'
end
