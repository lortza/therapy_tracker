# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :set_return_to_destination, only: [:edit]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to session.fetch(:return_to, root_path)
    else
      render :edit
    end
  end

  private

  def set_return_to_destination
    session[:return_to] ||= request.referer
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:enable_slit_tracking)
  end
end
