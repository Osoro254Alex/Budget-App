Rails.application.routes.draw do
  devise_for :users

  root 'home#homepage'
 
  resources :groups, only: [:index, :new, :create] do 
    resources :expenses, only: [:index, :new, :create]
  end
end
