Rails.application.routes.draw do
  mount PlayAuth::Engine => '/auth', :as => :auth
  root 'home#index'
  resources :notes
end
