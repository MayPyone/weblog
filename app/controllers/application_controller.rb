class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit({ roles: [] }, :email, :password, :password_confirmation, :name, :posts_counter)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit({ roles: [] }, :email, :name, :password, :password_confirmation, :current_password)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:name, :email)
    end

    devise_parameter_sanitizer.permit(:reset_password) do |user_params|
      user_params.permit(:email, :reset_password_token)
    end
  end
end
