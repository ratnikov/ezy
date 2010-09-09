Ezy::Application.routes.draw do
  root :to => 'routes#new'

  resources :routes
end
