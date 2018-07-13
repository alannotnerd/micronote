require 'test_helper'

class UsersLoginTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup 
    @user= users(:test)
  end

  test "login with valid information" do
    get login_path 
    post login_path, session: { email: @user.email,password: "qwerasdf" }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count:0
  end

  test "login with remembering" do
    log_in_as @user, remember_me: '1'
    assert is_logged_in?
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as @user, remember_me: '0'
    assert_nil cookies['remember_token']
  end
end
