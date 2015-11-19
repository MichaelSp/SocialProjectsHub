require 'test_helper'

class UserTest < ActiveSupport::TestCase

  subject{User.new}
  it 'can toggle the admin flag' do
    subject.admin = 0
    assert_equal 0, subject.roles
    assert_equal false, subject.admin?
    subject.admin = 1
    assert_equal 1, subject.roles
    assert_equal true, subject.admin?
    subject.admin = 0
    assert_equal 0, subject.roles
    assert_equal false, subject.admin?
  end
end
