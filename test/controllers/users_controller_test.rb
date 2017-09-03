require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  @@valid_user_params = { user: { name: "Aji", email: "user@example.com", password: "foobar", password_confirmation: "foobar" } }
  @@invalid_user_params = { user: { email: "user@example.com", password: "foobar", password_confirmation: "foobar" } }
  
  def setup
    @user = User.create(name: "Mina", email: "slater.mina@gmail.com", password: "welcome", password_confirmation: "welcome")
  end

  # tests users#new
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  # tests users#create
  test "should create user" do
    before_count = User.count
    post users_url, params: @@valid_user_params
    assert_equal before_count + 1, User.count 
  end

  test "should not create user with incorrect params" do
    before_count = User.count
    post users_url, params: @@invalid_user_params 
    assert_equal before_count, User.count
  end

  test "valid user adds message to flash success" do
    post users_url, params: @@valid_user_params
    assert_equal "welcome!", flash[:success]
  end

  test "invalid user adds messages to flash" do
    post users_url, params: @@invalid_user_params
    assert_equal "Name can't be blank", flash[:alert]
  end

  test "valid user redirects to show" do
    post users_url, params: @@valid_user_params
    user = User.last
    assert_redirected_to controller: "users", action: "show", id: user.id
  end

  test "invalid user should redirect to new" do
    post users_url, params: @@invalid_user_params 
    assert_redirected_to controller: "users", action: "new"
  end

  # tests users#show
  test "should get show" do
    get user_url(@user.id)
    assert_response :success
  end

  # tests users#update
  test "should update user with correct params" do
    login_test_user(@user)
    patch user_url(@user.id), params: { user: { name: "Kermit" } }
    assert_equal "Kermit", User.find(@user.id).name
  end

  test "should not update user with incorrect params" do
    login_test_user(@user)
    patch user_url(@user.id), params: { user: { name: "" } }
    assert_equal @user.name, User.find(@user.id).name
  end

  test "valid updated user adds message to flash success" do
    login_test_user(@user)
    patch user_url(@user.id), params: { user: { name: "Henson", email: "slater.mina@gmail.com" } }
    assert_equal "updated!", flash[:success]
  end

  test "invalid update user adds messages to flash alert" do
    login_test_user(@user)
    patch user_url(@user.id), params: { user: { name: "", email: "mina@example.com" } }
    assert_equal "Name can't be blank", flash[:alert]
  end

  test "valid user redirects to show from update" do
    login_test_user(@user)
    patch user_url(@user.id), params: { user: { name: "Henson", email: "slater.mina@gmail.com" } }
    assert_redirected_to controller: "users", action: "show", id: @user.id
  end

  test "invalid user should redirect to edit from update" do
    login_test_user(@user)
    patch user_url(@user.id), params: { user: { name: "", email: "mina@example.com" } }
    assert_redirected_to controller: "users", action: "edit", id: @user.id
  end

  # tests user#destroy
  test "should delete user" do
    user = User.create(name: "Donald Duck", email: "dd@example.com", password: "welcome", password_confirmation: "welcome")
    login_test_user(user)
    before_count = User.count
    delete user_url(user.id)
    assert_equal before_count - 1, User.count 
  end

  test "successful deletion redirects to root" do
    user = User.create(name: "Donald Duck", email: "dd@example.com", password: "welcome", password_confirmation: "welcome")
    login_test_user(user)
    delete user_url(user.id)
    assert_redirected_to root_path
  end
end

