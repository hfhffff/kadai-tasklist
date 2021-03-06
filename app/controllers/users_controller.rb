class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:show]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = '登録完了！　ようこそ、タスクリストへ！'
      redirect_to @user
    else
      flash[:danger] = '登録失敗・・・'
      render :new
    end
  end

  def show
    @task = current_user.tasks
    @user = User.find(params[:id])
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    unless current_user.id === params[:id].to_i
      redirect_to root_url
    end
  end
end