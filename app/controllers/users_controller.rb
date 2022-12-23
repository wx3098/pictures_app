class UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]
  def new 
    @user = User.new
  end

  def create
    @user = current_user.user.build(user_params)
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
  end


  def update
    if @user.update(user_params)
      redirect_to users_path, notice: '編集しました!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
