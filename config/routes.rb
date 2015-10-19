NoteMod::Engine.routes.draw do
  root 'home#index'
  resources :notes
end