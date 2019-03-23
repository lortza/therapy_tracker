class Admin::UsersController < AdminController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :admin, :password, :password_confirmation)
    end
end
