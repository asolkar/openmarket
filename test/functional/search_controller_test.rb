require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get simple" do
    get :simple
    assert_response :success
  end

  test "should get advanced" do
    get :advanced
    assert_response :success
  end

end
