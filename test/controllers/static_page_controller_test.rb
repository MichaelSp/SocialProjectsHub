require 'test_helper'

class StaticPageControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get imprint" do
    get :imprint
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

end
