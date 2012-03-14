require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  test "should get 404" do
    get :404
    assert_response :success
  end

  test "should get 500" do
    get :500
    assert_response :success
  end

end
