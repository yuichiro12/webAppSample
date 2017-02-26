class SessionsController < ApplicationController
  def login
    user = User.find_by(name: params[:sessions][:name])
    if user && user.authenticate(params[:sessions][:password])
      log_in user
      redirect_to @user
    else
      flash.now[:danger] = "invalid username or password"
      render "new"
    end
  end

  def logout
    log_out
    redirect_to root_url
  end
end
