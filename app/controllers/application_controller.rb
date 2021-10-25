class ApplicationController < ActionController::Base
  before_action :configre_permitted_paramter, if: :devise_controller?

  private
  def configre_permitted_paramter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
