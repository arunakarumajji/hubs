Rails.application.routes.draw do
  root "hubs#index"

  resources :hubs do
    resources :admins, only: [:new, :create]
    resources :email_configs

    resources :users do
      # Collection routes operate on the entire resource collection (no ID required):
      collection do
        post :send_invites  # Becomes /users/send_invites
      end
      # Member routes operate on a specific resource instance (requiring an ID):
      # These routes work on a specific user, so they need the user's ID.
      member do
        get :signup            # Becomes /users/:id/signup
        patch :complete_signup # Becomes /users/:id/complete_signup
      end
    end
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # Route for user signup via email link
  get 'hubs/:hub_slug/signup/:user_id', to: 'users#signup', as: 'user_signup'
  patch 'hubs/:hub_slug/complete_signup/:user_id', to: 'users#complete_signup', as: 'complete_user_signup'
end
