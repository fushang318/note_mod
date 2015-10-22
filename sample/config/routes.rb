Rails.application.routes.draw do
  mount NoteMod::Engine => '/', :as => 'note_mod'
  mount PlayAuth::Engine => '/auth', :as => :auth
end
