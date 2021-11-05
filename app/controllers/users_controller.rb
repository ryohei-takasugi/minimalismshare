class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    Notice.update(read: true)
  end
end
