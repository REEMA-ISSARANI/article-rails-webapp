class UsersController < ApplicationController

  #before_action :logged_in_user

  def new
  	 @user = User.new

  end
  
  def show
  	@user = User.find(params[:id])
  end
  
  def articles
    #@user = User.find(params[:id])
    @user = current_user
    puts @user
    puts current_user.name
    @articles = @user.articles
  end  

  def create
    @user = User.new
   
        @user.name = params[:users][:username]
		

		@user.email = params[:users][:email]
		

		@user.password = params[:users][:password]

    
    if @user.save
			log_in @user
			flash[:notice] = "You signed up successfully"
			#flash[:color] = "valid"
			redirect_to articles_path
			#redirect_to @user
        else
        	flash[:notice] = "Form is invalid"
        	#flash[:color] = "invalid"
        	render "new"
        end


  end

  #def logged_in_user
  #    unless logged_in?
  #      flash[:sorry] = "Please log in"
  #      redirect_to login_path
  #    end
  #  end   

# def user_params
# 	params.require(:user).permit(:name ,:email, :password)
# end

end
