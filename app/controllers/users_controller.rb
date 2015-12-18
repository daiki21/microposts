class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :authorize!, only: [:edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
        .paginate(page: params[:page], :per_page => 5)
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
  end
  
  def update
      if @user.update_attributes(user_params)
        redirect_to user_path(@user)
      else
        # Validation error
        render 'edit'
      end
  end
  
  def followings
    @title = "Following"
    @users = @user.following_users.paginate(page: params[:page], :per_page => 5)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.follower_users.paginate(page: params[:page], :per_page => 5)
    render 'show_follow'
  end
  
  
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :place, :bio)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def authorize!
    if @user != current_user
      redirect_to root_path, alert: "不正なアクセス！"
    end
  end
end
