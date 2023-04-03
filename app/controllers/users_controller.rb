class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[create]

  def index
    users = authorized_scope(User.all)
    render json: users
  end

  def company_users
    return render json: "company id is missing" unless params[:company_id]
    users = authorized_scope(User.all, type: :company_users, scope_options: { company_id: params[:company_id] })
    
    render json: users
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
