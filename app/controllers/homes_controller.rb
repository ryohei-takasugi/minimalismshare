class HomesController < ApplicationController
  # GET /homes
  def index
    redirect_to experiences_path if user_signed_in?
  end

  # GET /homes/about
  def about
  end
end
