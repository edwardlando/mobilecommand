require 'test_helper'

class PastpostsControllerTest < ActionController::TestCase
  setup do
    @pastpost = pastposts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pastposts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pastpost" do
    assert_difference('Pastpost.count') do
      post :create, pastpost: { body: @pastpost.body, shortlink: @pastpost.shortlink }
    end

    assert_redirected_to pastpost_path(assigns(:pastpost))
  end

  test "should show pastpost" do
    get :show, id: @pastpost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pastpost
    assert_response :success
  end

  test "should update pastpost" do
    put :update, id: @pastpost, pastpost: { body: @pastpost.body, shortlink: @pastpost.shortlink }
    assert_redirected_to pastpost_path(assigns(:pastpost))
  end

  test "should destroy pastpost" do
    assert_difference('Pastpost.count', -1) do
      delete :destroy, id: @pastpost
    end

    assert_redirected_to pastposts_path
  end
end
