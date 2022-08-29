class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    authorize! user, to: :show?
    
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
    user = User.find(params[:id])
    authorize! current_user, to: :update?

    user.update!(email: params[:email])
    render json: user
  end

  private
    
    def user_params
      params.permit(:email, :password)
    end
end
