class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :update, :destroy]

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
    render json: @conversation
  end

  # GET /conversations/1
  def show
    render json: @conversation, serializer: ConversationHistorySerializer
  end

  # POST /conversations
  def create
    @conversation = Conversation.new(name:params[:name])

    if @conversation.save
      render json: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conversations/1
  def update
    if @conversation.update(conversation_params)
      render json: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conversations/1
  def destroy
    @conversation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def conversation_params
      params.require(:conversation).permit(:name)
    end
end
