class UsersController < ApplicationController

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    @user.gen_token_and_salt
    if @user.save
      log_in_session(@user)
      flash[:success] = 'Welcome '+@user.name.capitalize+' !'
      redirect_to tanks_path
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :mail, :password, :password_confirmation)
  end

end
