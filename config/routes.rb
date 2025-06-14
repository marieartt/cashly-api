Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  post "login" => "authentication#login"

  get "up" => "rails/health#show", as: :rails_health_check
  
  namespace :api do
    resources :users do
      collection do
        get :me, to: "users#me"
      end
    end

    resources :credit_cards
    resources :transactions

    resources :dashboard, only: [] do
      collection do
        get :summary
      end
    end
  end
end
