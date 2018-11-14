require 'test_helper'

class CoinsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coin" do
    assert_difference('Coin.count') do
      post :create, :coin => { }
    end

    assert_redirected_to coin_path(assigns(:coin))
  end

  test "should show coin" do
    get :show, :id => coins(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => coins(:one).to_param
    assert_response :success
  end

  test "should update coin" do
    put :update, :id => coins(:one).to_param, :coin => { }
    assert_redirected_to coin_path(assigns(:coin))
  end

  test "should destroy coin" do
    assert_difference('Coin.count', -1) do
      delete :destroy, :id => coins(:one).to_param
    end

    assert_redirected_to coins_path
  end
end
