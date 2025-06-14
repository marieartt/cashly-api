class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_request!, except: [:create, :index]

  # GET /users
  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

  # GET /users/:id
  def show
    render json: @user, serializer: UserSerializer
  end

  # POST /users/:id
  def create
    @user = User.new(user_params)
    if @user.save
      token = AuthenticationService.encode(@user)
      render json: {token: token, user: @user}, status: :created
    else
      render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
    end
  end

  # PUT/PATCH /users/:id
  def update
    if @user.update(user_params)
      render json: @user, serializer: UserSerializer
    else
      render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  # GET /users/me
  def me
    @user = @current_user
    if @user
      render json: @user, serializer: UserSerializer
    else
      render json: { message: 'Usuário não encontrado' }, status: :not_found
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Usuário não encontrado' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :email, 
      :password, 
      :password_confirmation, 
      :name, 
      :phone, 
      :birthdate,
      user_detail_attributes: [:phone, :birthdate]
      )
  end
end
