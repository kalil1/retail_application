require "test_helper"

class ApprovalQueueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get approval_queue_index_url
    assert_response :success
  end

  test "should get approve" do
    get approval_queue_approve_url
    assert_response :success
  end

  test "should get reject" do
    get approval_queue_reject_url
    assert_response :success
  end
end
