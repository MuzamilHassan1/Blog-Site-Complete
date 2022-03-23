class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #making login session for the users
      session[:user_id] = user.id
      flash[:notice]="You've logged in successfully"
      redirect_to user
    else
      #using new because we aren't redirecting, (flash requires one https cycle and redirect_to gives that cycle)
      #flash now does not persist for one full https request (current case)
      flash.now[:alert]="Incorrect Credentials"
      render 'new'
    end
  end

  def destroy
    #when user logged out set session id to nil
    session[:user_id] = nil
    flash[:notice]="You've logged out successfully"
    redirect_to root_path
  end
end
