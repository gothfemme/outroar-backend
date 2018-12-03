class ConversationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_conversation, only: [:show, :update, :destroy, :validate]

  # GET /conversations
  def index
    if params[:search]
      @conversations = Conversation.where("name ILIKE :search", search: "%#{params[:search]}%")
    elsif params[:popular]
      @conversations = Conversation.left_joins(:favorites).group(:id).order('COUNT(favorites.conversation_id) DESC').limit(10)
    else
      @conversations = Conversation.all
    end

    render json: @conversations
  end

  def random
    @conversation = Conversation.all.sample
    render json: {id: @conversation.id}
  end

  # GET /conversations/1
  def show
    if @conversation.owner == current_user
      render json: @conversation, serializer: AdminConversationHistorySerializer
    else
      render json: @conversation, serializer: ConversationHistorySerializer
    end
  end

  # POST /conversations
  def create
    @conversation = Conversation.new(name:params[:name], user_id: current_user.id)

    if @conversation.save
      render json: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conversations/1
  def update
    if @conversation.owner == current_user
      if @conversation.update(conversation_params)
        render json: @conversation
      else
        render json: @conversation.errors, status: :unprocessable_entity
      end
    end
  end

  def validate
    if @conversation.password == params[:password]
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  # DELETE /conversations/1
  def destroy
    if @conversation.owner.id == current_user.id
      @conversation.destroy
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def conversation_params
      params.require(:conversation).permit(:name, :password)
    end
end
