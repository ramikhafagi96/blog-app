class UsersController <  ApplicationController
    before_action :set_user, only: [:show, :edit, :update]

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
end