require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest

  let(:user){users(:one)}
  it "User can login in" do
    get login_path
    assert_select 'form input[name="user[login]"]'
    assert_select 'form input[name="user[password]"]'
    post_via_redirect login_path, {user: {login: user.email, password: 'MyString'}}
    assert_not_nil session[:user_id]
    assert_equal projects_path,  request.original_fullpath
    assert_select '.ui.red.button', 'Logout'
  end

  test "User can logout" do
    post_via_redirect login_path, {user: {login: user.email, password: 'MyString'}}
    delete_via_redirect logout_path
    assert_nil session[:user_id]
    assert_select '.ui.red.button', {count: 0, text: 'Logout'}
    assert_select '.ui.button', 'Login & Sign up'
  end


  test 'cant login' do
    post_via_redirect login_path, {user: {login: 'evil', password: 'none'}}
    assert_equal login_path, request.original_fullpath
    assert_select '.ui.message', 'Authentication failed!'
  end
end