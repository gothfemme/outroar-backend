class UsersController < ApplicationController
  before_action :authenticate_user, only: [:splash, :current, :index, :show, :update, :destroy]
  before_action :set_user, only: [:show, :destroy]

  def splash
    render json: ActiveModel::Serializer::CollectionSerializer.new(current_user.conversations, serializer: ConversationSerializer)
  end

  def current
    render json: current_user, serializer: UserSerializer
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])

    if @user.save
      token = Knock::AuthToken.new(payload: { sub: @user.id }).token
      render json: {user: UserSerializer.new(@user), token: token}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if current_user.update(color: params[:color])
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
