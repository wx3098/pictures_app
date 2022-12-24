class UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to  user_path(@user.id)
    else
        render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id == @user.id
    else
        redirect_to user_path(@user.id)
        flash[:notice] = '他のユーザーのプロフィールを編集することはできません。'
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "情報を編集しました！"
        redirect_to user_path
    else
        render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :imag_cache)
  end
end
