class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

 #  def configure_permitted_parameters
 #   devise_parameter_sanitizer.for(:sign_in)        << :username
 #   devise_parameter_sanitizer.for(:sign_up)        << :username
 #   devise_parameter_sanitizer.for(:account_update) << :username
	# end

	 def configure_permitted_parameters
    registration_params = [:email, :usernamename, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(registration_params) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(registration_params << :current_password) }
  end

	# def configure_permitted_parameters
	#   devise_parameter_sanitizer.permit(:sign_in) do |user_params|
	#     user_params.permit(:username, :email)
	#   end
		

	# 	devise_parameter_sanitizer.permit(:sign_up) do |user_params|
	#     user_params.permit(:username, :email)
	#   end
		

	# 	devise_parameter_sanitizer.permit(:account_update) do |user_params|
	#     user_params.permit(:username, :email)
	#   end
	# end

end
