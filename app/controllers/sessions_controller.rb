class SessionsController < ApplicationController
  def login
    user = User.find_by(email: user_params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      render json:{
        user: user,
        session: session[:user_id]
      }
    else
      render json: "email or password are incorrect", status: 500
    end
  end

  def logged_in
    if current_user  
      render json: current_user
    else 
      render json: false
    end
  end

  def logout
    reset_session
    render json: "successfully logged out"
  end

  private
    
    def user_params
      params.permit(:email, :password)
    end
end
