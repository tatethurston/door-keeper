class AuthController < ApplicationController
  skip_after_action :verify_policy_scoped

  def index
    render json: current_user.as_json(only: [
      :id,
      :name,
      :email,
      :image,
    ])
  end

  def destroy
    sign_out current_user

    head :ok
  end
end
