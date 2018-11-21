require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
  end

  test "should get index" do
    get memberships_url, as: :json
    assert_response :success
  end

  test "should create membership" do
    assert_difference('Membership.count') do
      post memberships_url, params: { membership: { conversation_id: @membership.conversation_id, user_id: @membership.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show membership" do
    get membership_url(@membership), as: :json
    assert_response :success
  end

  test "should update membership" do
    patch membership_url(@membership), params: { membership: { conversation_id: @membership.conversation_id, user_id: @membership.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy membership" do
    assert_difference('Membership.count', -1) do
      delete membership_url(@membership), as: :json
    end

    assert_response 204
  end
end
