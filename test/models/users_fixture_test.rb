require "test_helper"
class UserFixtureTest < ActiveSupport::TestCase
  test "fixture should load correctly" do
    assert_equal User.all.size, 34
  end
end
