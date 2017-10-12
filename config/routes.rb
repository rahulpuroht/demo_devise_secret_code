Rails.application.routes.draw do

  root to: 'welcomes#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :secret_codes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
