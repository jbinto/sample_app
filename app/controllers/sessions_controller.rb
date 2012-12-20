class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if (user && user.authenticate(params[:session][:password]))  # tricky; because it returns false if wrong pw
      # Sign in the user.
      session[:user] = user
      redirect_to user 
    else
      flash.now[:error] = "Invalid username/password."
      render 'new'
    end
  end

  def destroy
  end
end
