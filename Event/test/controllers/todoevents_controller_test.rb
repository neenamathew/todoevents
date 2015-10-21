require 'test_helper'

class TodoeventsControllerTest < ActionController::TestCase
  setup do
    @todoevent = todoevents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todoevents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todoevent" do
    assert_difference('Todoevent.count') do
      post :create, todoevent: {  }
    end

    assert_redirected_to todoevent_path(assigns(:todoevent))
  end

  test "should show todoevent" do
    get :show, id: @todoevent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todoevent
    assert_response :success
  end

  test "should update todoevent" do
    patch :update, id: @todoevent, todoevent: {  }
    assert_redirected_to todoevent_path(assigns(:todoevent))
  end

  test "should destroy todoevent" do
    assert_difference('Todoevent.count', -1) do
      delete :destroy, id: @todoevent
    end

    assert_redirected_to todoevents_path
  end
end
