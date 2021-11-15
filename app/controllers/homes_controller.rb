class HomesController < ApplicationController
  def index
    redirect_to experiences_path if user_signed_in?
  end

  def about
  end
end
