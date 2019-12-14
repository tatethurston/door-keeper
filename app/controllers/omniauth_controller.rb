class OmniauthController < Devise::OmniauthCallbacksController
  skip_after_action :verify_policy_scoped

  def google_oauth2
    data = request.env["omniauth.auth"].info

    user = User.where(email: data["email"]).first_or_initialize.tap do |user|
      user.name  = data["name"]
      user.email = data["email"]
      user.image = data["image"]

      user.save!
    end

    sign_in_and_redirect user, event: :authentication
  end
end
