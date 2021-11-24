class ApplicationController < ActionController::Base
  before_action :confirm_basic_auth
  before_action :set_instance_notices

  private

  def confirm_basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def set_instance_notices
    @notices = Notice.recent(current_user.id) if user_signed_in?
  end
end
