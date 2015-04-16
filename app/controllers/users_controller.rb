class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users/1
  def show
    # set_user #Not required as called in the before_action
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # This 'permit' code replaces the deprecated attr_accessible in the model
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
  end

end
