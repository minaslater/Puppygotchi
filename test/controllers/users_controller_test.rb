require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  @@valid_user_params = { user: { name: "Aji", email: "user@example.com", password: "foobar", password_confirmation: "foobar" } }
  @@invalid_user_params = { user: { email: "user@example.com", password: "foobar", password_confirmation: "foobar" } }
  
  def setup
    @user = User.create(name: "Mina", email: "slater.mina@gmail.com", password: "barfoo", password_confirmation: "barfoo")
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

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
    assert_redirected_to controller: "users", action: "show", id: "2"
  end

  test "invalid user should redirect to new" do
    post users_url, params: @@invalid_user_params 
    assert_redirected_to controller: "users", action: "new"
  end

  test "should get show" do
    get user_url(@user.id)
    assert_response :success
  end

  test "should update user with correct params" do
    patch user_url(@user.id), params: { user: { name: "Kermit" } }
    assert_equal "Kermit", User.find(@user.id).name
  end

  test "should not update user with incorrect params" do
    patch user_url(@user.id), params: { user: { name: "" } }
    assert_not_equal "", User.find(@user.id).name
  end

  test "valid updated user adds message to flash success" do
    patch user_url(@user.id), params: { user: { name: "Henson", email: "slater.mina@gmail.com" } }
    assert_equal "updated!", flash[:success]
  end

  test "invalid update user adds messages to flash alert" do
    patch user_url(@user.id), params: { user: { name: "", email: "mina@example.com" } }
    assert_equal "Name can't be blank", flash[:alert]
  end

  test "valid user redirects to show from update" do
    patch user_url(@user.id), params: { user: { name: "Henson", email: "slater.mina@gmail.com" } }
    assert_redirected_to controller: "users", action: "show", id: @user.id
  end

  test "invalid user should redirect to edit from update" do
    patch user_url(@user.id), params: { user: { name: "", email: "mina@example.com" } }
    assert_redirected_to controller: "users", action: "edit", id: @user.id
  end
end
