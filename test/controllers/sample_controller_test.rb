require "test_helper"

class SampleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sample_index_url
    assert_response :success
  end

  test "should get create" do
    get sample_create_url
    assert_response :success
  end

  test "should get update" do
    get sample_update_url
    assert_response :success
  end

  test "should get delete" do
    get sample_delete_url
    assert_response :success
  end
end
