class SessionsController < ApplicationController
  # GET /sessions/new
  def new

  end

  # POST /sessions
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the users show page
      sign_in user
      redirect_to user
    else
      # Create an error message and re-render the Sign in page
      flash.now[:error] = 'Invalid password/email combination'
      render 'new'
    end
  end

  #DELETE /sessions/:id
  def destroy
    sign_out
    redirect_to root_path
  end
end
