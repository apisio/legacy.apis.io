require 'test_helper'

class BiblesControllerTest < ActionController::TestCase
  setup do
    @bible = bibles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bibles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bible" do
    assert_difference('Bible.count') do
      post :create, bible: @bible.attributes
    end

    assert_redirected_to bible_path(assigns(:bible))
  end

  test "should show bible" do
    get :show, id: @bible.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bible.to_param
    assert_response :success
  end

  test "should update bible" do
    put :update, id: @bible.to_param, bible: @bible.attributes
    assert_redirected_to bible_path(assigns(:bible))
  end

  test "should destroy bible" do
    assert_difference('Bible.count', -1) do
      delete :destroy, id: @bible.to_param
    end

    assert_redirected_to bibles_path
  end
end
