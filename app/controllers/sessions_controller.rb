class SessionsController < ApplicationController
  def new
  end
  
  def create
  	puts "========================"
  	puts params[:session][:email]

  user = User.find_by(email: params[:session][:email].downcase)

  #if user && user.authenticate(params[:session][:password])
    if user.present? && user.valid?  
       log_in user
       remember user
       #redirect_to user
       redirect_to articles_path 

    else
      flash.now[:danger] = 'Invalid email/password combination'  
  	  render 'new'
  end

  end

  def destroy
    log_out

    redirect_to login_path
  end

end
