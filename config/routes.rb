Slideonline::Application.routes.draw do

  resources :categories, :only => [:create,:destroy,:index, :show]

  get "favourites/create"
  get "favourites/destroy"
  devise_for :users, controllers: {
		registrations: "devise_extensions/registrations"
	}


	#get all powerpoints with this tag
	get 'tagged' => 'powerpoints#tagged', :as => 'tagged'
	#get current user's favourites
	get 'favourited' => 'powerpoints#favourites', :as => 'favourited'
  #for manage page
	get 'manage' => 'home#leokmaxloveemilyforever', :as => 'manage'
	#resources :users do
	#  get '/users/:id', :to => 'users#show'
	#  patch '/users/:id', :to => 'users#update'
  #end

	resources :comments, :only => [:create, :destroy]
	resources :powerpoints
	resources :powerpoints do
		resources :favourites, only: [:create, :destroy]
	end
  root 'home#index'
end
