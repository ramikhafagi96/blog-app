class UsersController <  ApplicationController


   def index
    @users = User.all
   end
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

   def edit
    @user = User.find(params[:id])
   end

   def update
    @user = User.find(params[:id])
    if @user.update(whitlist_params)
        flash[:notice] = "Your Account Information Were Successfully Updated"
        redirect_to articles_path
    else
        render 'edit'
    end
   end

   def show
    @user = User.find(params[:id])
    @articles = @user.articles
   end


   private

   def whitlist_params
    params.require(:user).permit(:username, :email, :password)
   end
end