Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth" }
  devise_scope :user do
    get "users/auth/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end
  get "users/auth", to: "auth#index", as: :user_session

  scope "/api" do
    resources :doors, only: [:index, :show]
    resources :codes, only: [:index, :show]
    resources :access_logs, only: [:index]

    resources :twilio, only: [:index] do
      collection do
        post :access
      end
    end
  end
end
