require 'test_helper'

class MashupsControllerTest < ActionController::TestCase
  setup do
    @mashup = mashups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mashups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mashup" do
    assert_difference('Mashup.count') do
      post :create, mashup: { api_id: @mashup.api_id, mashupdesc: @mashup.mashupdesc, mashupimageurl: @mashup.mashupimageurl, mashupname: @mashup.mashupname, mashupurl: @mashup.mashupurl, user_id: @mashup.user_id }
    end

    assert_redirected_to mashup_path(assigns(:mashup))
  end

  test "should show mashup" do
    get :show, id: @mashup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mashup
    assert_response :success
  end

  test "should update mashup" do
    put :update, id: @mashup, mashup: { api_id: @mashup.api_id, mashupdesc: @mashup.mashupdesc, mashupimageurl: @mashup.mashupimageurl, mashupname: @mashup.mashupname, mashupurl: @mashup.mashupurl, user_id: @mashup.user_id }
    assert_redirected_to mashup_path(assigns(:mashup))
  end

  test "should destroy mashup" do
    assert_difference('Mashup.count', -1) do
      delete :destroy, id: @mashup
    end

    assert_redirected_to mashups_path
  end
end
