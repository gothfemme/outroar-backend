require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation = conversations(:one)
  end

  test "should get index" do
    get conversations_url, as: :json
    assert_response :success
  end

  test "should create conversation" do
    assert_difference('Conversation.count') do
      post conversations_url, params: { conversation: { name: @conversation.name } }, as: :json
    end

    assert_response 201
  end

  test "should show conversation" do
    get conversation_url(@conversation), as: :json
    assert_response :success
  end

  test "should update conversation" do
    patch conversation_url(@conversation), params: { conversation: { name: @conversation.name } }, as: :json
    assert_response 200
  end

  test "should destroy conversation" do
    assert_difference('Conversation.count', -1) do
      delete conversation_url(@conversation), as: :json
    end

    assert_response 204
  end
end
