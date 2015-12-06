class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    if @user != current_user
    # ログインしていないか別のユーザーでログインしている場合。
    redirect_to root_path, alert: '不正なアクセス'
    else
    end
  end
  
  def update
    if @user != current_user
      # ログインしていないか別のユーザーでログインしている場合。
      redirect_to root_path, alert: '不正なアクセスです'
    else
      if @user.update_attributes(user_params)
        redirect_to user_path(@user)
      else
        # Validation error
        render 'edit'
      end
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :place, :bio)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
