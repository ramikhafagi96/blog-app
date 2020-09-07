class UsersController <  ApplicationController

   def new
    @user = User.new
   end

   def create
    @user = User.new(whitlist_params)
    if @user.save
        flash[:notice] = "Welcome To Blog Hub #{@user.username}"
        redirect_to articles_path
    else
        render 'new'
    end
   end

   private

   def whitlist_params
    params.require(:user).permit(:username, :email, :password)
   end
end