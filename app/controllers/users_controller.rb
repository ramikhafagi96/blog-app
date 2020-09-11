class UsersController <  ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :is_authorized, only: [:edit, :update, :destroy]

   def index
    @users = User.paginate(page: params[:page], per_page: 5)
   end

   def new
    @user = User.new
   end

   def create
    @user = User.new(whitelist_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome To Blog Hub #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
   end

   def destroy
     @user.destroy
     session[:user_id] = nil if current_user == @user
     flash[:notice] = "Account and all associated articles are deleted"
     redirect_to articles_path
   end

   def edit
   end

   def update
    if @user.update(whitelist_params)
      flash[:notice] = "Your Account Information Were Successfully Updated"
      redirect_to @user #user_path(@user)
    else
      render 'edit'
    end
   end

   def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5) 
   end



   private

   def whitelist_params
    params.require(:user).permit(:username, :email, :password)
   end

   def set_user
    @user = User.find(params[:id])
   end

   def is_authorized
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You are not the owner of the profile"
      redirect_to @user
    end
   end
end