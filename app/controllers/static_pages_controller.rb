class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      @feed_items = current_user.microposts.paginate(page: params[:page], :per_page => 5)
    end
  end
end
