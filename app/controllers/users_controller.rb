class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[create]

  def index
    render json: User.all
  end

  def show
    # show if user is admin or self_record 
    user = User.find(params[:id])
    authorize! user, to: :show? # user is record in this case
    
    render json: user
  end

  def create
    user = User.create! user_params
    session[:user_id] = user.id
    
    render json:{
      user: user,
      session: session[:user_id]
    }
  end

  def update
    # update if user is admin or self_record
    user = User.find(params[:id])
    authorize! current_user, to: :update?

    user.update!(email: params[:email])
    render json: user
  end

  private
    
    def user_params
      params.permit(:email, :password, :role)
    end
end
