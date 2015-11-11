require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "search by name" do
    assert_equal [projects(:one)], Project.full_text_search('fancy').to_a
  end

  test "search by category" do
    assert_equal [projects(:one)], Project.full_text_search('First').to_a
    assert_equal [projects(:two)], Project.full_text_search('second').to_a
  end

  test "substring search" do
    skip "Not supported by 'pg_search' gem "
    assert_equal [projects(:one)], Project.full_text_search('Fir').to_a
    assert_equal [projects(:two)], Project.full_text_search('ond').to_a
  end
end
