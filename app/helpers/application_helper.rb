module ApplicationHelper

    def current_user
      #memoization
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end
end 
