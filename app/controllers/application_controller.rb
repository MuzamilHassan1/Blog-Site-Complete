class ApplicationController < ActionController::Base

  #to make current_user available in the articles-contoller we specify it here
  #we also want it to be available in views thats why we specified helper_method
  helper_method :current_user, :logged_in?
  def current_user
    #if we have referenced current_user before(cache) then return the user
    #else check if current user exists in the session
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #convert the output from current_user to booleand using two bangs
    !!current_user
  end
end
