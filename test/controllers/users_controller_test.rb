require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    login users(:admin)
  end
  let (:user){users(:one)}

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: user.email, password: 'pwd', name: user.name, phone: user.phone }
      assert_equal({}, assigns(:user).errors.messages)
    end
    assert_redirected_to users_path
  end

  test "should get edit" do
    get :edit, id: user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: user, user: { email: user.email, password: 'pwd', name: user.name,
                                      phone: user.phone, admin: user.admin? }
    assert_equal({}, assigns(:user).errors.messages)
    assert_redirected_to users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: users(:one).id
    end

    assert_redirected_to users_path
  end

  test 'set admin permission' do
    assert_equal false, user.admin?
    patch :update, id: user.id, user: { admin: 1}
    user.reload
    assert_equal({}, user.errors.messages)
    assert_equal true, user.admin?
  end

  test 'set translator permission' do
    assert_equal false, user.translator?
    patch :update, id: user.id, user: {translator: 1}
    user.reload
    assert_equal({}, user.errors.messages)
    assert_equal true, user.translator?
  end
end
