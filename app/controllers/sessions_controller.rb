class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = 'Email or password is invalid'
      # render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def login_params
    params.permit(:email, :password)
  end
end
