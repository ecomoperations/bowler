require 'test_helper'

class BowlsControllerTest < ActionController::TestCase
  setup do
    @bowl = bowls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bowls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bowl" do
    assert_difference('Bowl.count') do
      post :create, bowl: {  }
    end

    assert_redirected_to bowl_path(assigns(:bowl))
  end

  test "should show bowl" do
    get :show, id: @bowl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bowl
    assert_response :success
  end

  test "should update bowl" do
    patch :update, id: @bowl, bowl: {  }
    assert_redirected_to bowl_path(assigns(:bowl))
  end

  test "should destroy bowl" do
    assert_difference('Bowl.count', -1) do
      delete :destroy, id: @bowl
    end

    assert_redirected_to bowls_path
  end
end
