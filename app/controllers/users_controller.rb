class UsersController < ApplicationController
  def new
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
