require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get searches_home_url
    assert_response :success
  end

  test "should get result" do
    get searches_result_url
    assert_response :success
  end
end
