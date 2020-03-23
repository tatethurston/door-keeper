Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth" }
  get "users/auth", to: "auth#index", as: :user_session
  get "users/auth/sign_out", to: "auth#destroy", as: :destroy_user_session

  scope "/api" do
    resources :doors, only: [:index, :show]
    resources :codes, only: [:index, :show]
    resources :access_logs, only: [:index, :show]

    resources :twilio, only: [:index] do
      collection do
        post :access
      end
    end
  end

  get '*path', to: 'frontend#index', constraints: -> (request) {
    !request.xhr? && request.format.html?
  }
end
