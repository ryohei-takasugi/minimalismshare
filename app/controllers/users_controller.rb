class UsersController < ApplicationController
  # Call Views: users/show.html.erb
  def show
    @user = User.find(params[:id])
    Notice.update(read: true)
  end
end
