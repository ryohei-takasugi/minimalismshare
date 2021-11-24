class ApplicationController < ActionController::Base
  before_action :confirm_basic_auth
  before_action :configre_permitted_paramter, if: :devise_controller?
  before_action :set_notice

  private

  def configre_permitted_paramter
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :dream, :high_id, :low_id, :housemate_id, :hobby_id, :clean_status_id,
                                             :range_with_store_id])
  end

  def confirm_basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def set_notice
    @notices = Notice.where(user_id: current_user.id).limit(10).order(created_at: :desc) if user_signed_in?
  end
end
