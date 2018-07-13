require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test)
  end

  test "unsuccessful edit" do
    log_in_as @user 
    get edit_user_path @user
    patch user_path @user, user: {
      name: "",
      email: "foo@invalid",
      password: "dsf",
      password_confirmation: "dfag"
    }
    assert_template "users/edit"
  end

  test "unsuccessful edit name&email " do
    log_in_as @user
    get edit_user_path @user
    patch user_path @user,user: {
      name: "test_edit",
      email: "test_edit@test.com",
      password: "",
      password_confirmation: ""
    }
  end

  test "successful edit with friendly forwording" do
    get edit_user_path @user
    log_in_as @user
    assert_redirected_to edit_user_path @user
    patch user_path @user, user: {
      name: "test_edit",
      email: "test_edit@test.com",
      password: "",
      password_confirmation: ""
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, "test_edit"
    assert_equal @user.email, "test_edit@test.com"
  end
end
