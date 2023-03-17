Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # actions are methods in the controller
  # index, show, new, create, edit, update, destroy
  resources :users do 
    resources :subs, only: [:new, :create, :edit, :update, :index]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index, :destroy]

end
