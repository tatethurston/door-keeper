class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  after_action :set_csrf_cookie
  after_action :verify_policy_scoped

  rescue_from StandardError, with: :rescue_error

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end

  private

  def rescue_error(error)
    case error
    when Pundit::NotAuthorizedError
      render json: { error: ["Unauthorized"] }, status: :unauthorized
    when ActiveRecord::RecordInvalid
      render json: { error: error.record.errors.full_messages }, status: :unprocessable_entity
    when ActiveRecord::RecordNotFound
      render json: { error: ["Not Found"] }, status: :not_found
    else
      render json: { error: [error.message] }
    end
  end

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end
end
