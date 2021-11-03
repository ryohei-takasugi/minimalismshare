class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configre_permitted_paramter, if: :devise_controller?

  private

  def configre_permitted_paramter
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :dream, :region_id, :climate_id, :housemate_id, :children_id,
                                             :clean_status_id])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
