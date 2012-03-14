require 'test_helper'

class HambriefsControllerTest < ActionController::TestCase
  setup do
    @hambrief = hambriefs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hambriefs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hambrief" do
    assert_difference('Hambrief.count') do
      post :create, hambrief: @hambrief.attributes
    end

    assert_redirected_to hambrief_path(assigns(:hambrief))
  end

  test "should show hambrief" do
    get :show, id: @hambrief.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hambrief.to_param
    assert_response :success
  end

  test "should update hambrief" do
    put :update, id: @hambrief.to_param, hambrief: @hambrief.attributes
    assert_redirected_to hambrief_path(assigns(:hambrief))
  end

  test "should destroy hambrief" do
    assert_difference('Hambrief.count', -1) do
      delete :destroy, id: @hambrief.to_param
    end

    assert_redirected_to hambriefs_path
  end
end
