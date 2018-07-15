require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    Datafolder::Env.init
    @user = users :test
    @user_other = users :Man
    @user_other.save
    @user.save
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to login_url
  end

  test "should be blocked when trying to edit others profile" do
   log_in_as @user
   get :edit, id: @user_other
   assert_redirected_to root_url
  end

  test "should be blocked when trying to update others profile" do
    log_in_as @user
    patch :update, id: @user_other, user: { name: @user.name, email: @user.email }
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url 
  end

  test "should redirect destroy when logged in as a non-admin user" do
    log_in_as(@user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user_other
    end
    assert_redirected_to root_url
  end

  test "should delete user" do
    log_in_as @user_other
    get :index
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text:user.name
      unless user==@user_other
        assert_select 'a[href=?]', user_path(user), text: 'delete', method: :delete
      end
    end
    @user.create_home
    assert_difference 'User.count', -1 do
      delete :destroy, id: @user
    end
  end

  test "index as non-admin" do
    log_in_as(@user)
    get :index
    assert_select 'a', text: 'delete', count: 0, method: :delete
  end

  def teardown
    Datafolder::Env.drop
  end
end
