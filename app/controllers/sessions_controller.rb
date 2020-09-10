class SessionsController < ApplicationController
    def new
    end
    
    def create
        user = User.find_by(username: params[:session][:username].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Logged In Successfully"
            redirect_to user
        else
            flash.now[:alert] = "Check your login details"
            render 'new'
        end
            
    end
    
    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged Out"
        redirect_to root_path
    end
    
end