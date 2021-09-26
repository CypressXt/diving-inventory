class UsersController < ApplicationController
  before_action :must_be_logged, except: [:new, :create]
  before_action :must_be_admin, only: [:index, :delete, :destroy, :revoke_admin, :promote_admin]
  before_action :must_be_admin_or_myself, only: [:show]

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

  def index
    @users = User.all
  end

  def show
    @user = User.find(params["id"])
    @pressure_diving_logs = []
    if @user
      @pressure_diving_logs = @user.pressurelogs
    end
  end

  def revoke_admin
    @user = User.find(params["user_id"])
    if @user
      is_admin = false
      change_admin_privilege(@user, is_admin)
      redirect_to users_path
    end
  end

  def promote_admin
    @user = User.find(params["user_id"])
    if @user
      is_admin = true
      change_admin_privilege(@user, is_admin)
      redirect_to users_path
    end
  end

  def delete
    @user = User.find(params["user_id"])
  end

  def destroy
    @user = User.find(params["id"])
    if @user.destroy
      flash[:success] = 'User '+@user.name.capitalize+" "+@user.lastname.capitalize+' removed !'
      redirect_to users_path
    else
      flash[:danger] = 'Failed to remove the user ' + @user.name.capitalize+" "+@user.lastname.capitalize
      redirect_to user_path(@user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :mail, :password, :password_confirmation)
  end

  @private
  def change_admin_privilege(user, is_admin)
    user.admin = is_admin
    user.password_confirmation = user.password
    action = ""
    if is_admin
      action = ["added", "add"]
    else
      action = ["removed", "remove"]
    end
    if user.save
      flash[:success] = 'Admin privilege for'+user.name.capitalize+' has been '+action.first+" successfully"
    else
      flash[:danger] = 'Failed to '+action.last+' admin privilege for '+user.name.capitalize
    end
  end

end
