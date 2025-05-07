Rails.application.routes.draw do
  root "hubs#index"

  resources :hubs do
    resources :admins, only: [:new, :create]
    resources :email_configs
    resources :activities, only: [:index]

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
    resources :challenges do
      member do
        get :assign
        post :process_assignment
        get :thank_you
      end
      resources :story_submissions, only: [:new, :create]
    end
    # User-facing challenge routes
    resources :user_challenges, path: 'users/:user_id/challenges', only: [:index, :show] do
      member do
        post :complete
      end
    end
  end
  # Admin challenge management
  # resources :challenges do
  #   post :assign, on: :member
  # end


  # Admin authentication
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # User authentication
  get '/user/login', to: 'user_sessions#new', as: 'user_login'
  post '/user/login', to: 'user_sessions#create'
  delete '/user/logout', to: 'user_sessions#destroy', as: 'user_logout'


  # Route for user signup via email link
  get 'hubs/:hub_slug/signup/:user_id', to: 'users#signup', as: 'user_signup'
  patch 'hubs/:hub_slug/complete_signup/:user_id', to: 'users#complete_signup', as: 'complete_user_signup'
end
