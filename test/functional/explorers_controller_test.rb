require 'test_helper'

class ExplorersControllerTest < ActionController::TestCase
  setup do
    @explorer = explorers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:explorers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create explorer" do
    assert_difference('Explorer.count') do
      post :create, explorer: @explorer.attributes
    end

    assert_redirected_to explorer_path(assigns(:explorer))
  end

  test "should show explorer" do
    get :show, id: @explorer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @explorer
    assert_response :success
  end

  test "should update explorer" do
    put :update, id: @explorer, explorer: @explorer.attributes
    assert_redirected_to explorer_path(assigns(:explorer))
  end

  test "should destroy explorer" do
    assert_difference('Explorer.count', -1) do
      delete :destroy, id: @explorer
    end

    assert_redirected_to explorers_path
  end
end
