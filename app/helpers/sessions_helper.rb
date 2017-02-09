module SessionsHelper

def log_in(user)
    session[:user_id] = user.id

    puts session[:user_id]
end

def current_user
	puts "==========================================="
    #@current_user ||= User.find_by(id: session[:user_id])
    puts session[:user_id]
    puts @current_user

    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
     if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
      puts @current_user.name
      puts "###!!!!!!!!!!!!!!!!!!!!!!!!"
    elsif (user_id = cookies.signed[:user_id])
      puts user_id
      user = User.find_by(id: user_id)
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      if user && user.authenticated?(cookies[:remember_token])
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        log_in user
        @current_user = user
      end
    end
    return @current_user
end

#def current_user?(user)
#	user == current_user
#end	

def logged_in?
	puts "+++++++++++++++++++++++++++++++++++++++++++++"
	!current_user.nil?
end

#def log_out
#	puts"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#	session.delete(:user_id)
#	@current_user = nil
#end

def log_out
  forget(current_user)
  puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  puts session
    session.delete(session[:user_id])
    session[:user_id] = nil
    puts session[:user_id]
    #user_id = session[:user_id]
    #puts user_id
    @current_user = nil
    puts @current_user
end


def remember(user)
  puts "**********************************************"
	user.remember
  puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
	cookies.permanent.signed[:user_id]=user.id
  cookies.permanent[:remember_token] = user.remember_token
end

def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
end


end
