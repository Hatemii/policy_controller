class ApplicationController < ActionController::API
  include ActionPolicy::Controller
  authorize :user, through: :current_user
  
  # first way
  rescue_from ActionPolicy::Unauthorized do |exception|
    render json: exception # "Not Authorized"
  end

  # second way
  # rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized
  # def user_not_authorized
  #   render json: "You are not authorized to perform this action."
  # end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    render json: "you need to login first" unless current_user
  end
end
