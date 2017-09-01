require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  @@valid_user_params = { user: { name: "Aji", email: "user@example.com", password: "foobar", password_confirmation: "foobar" } }
  @@invalid_user_params = { user: { email: "user@example.com", password: "foobar", password_confirmation: "foobar" } }
  
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
    assert_redirected_to controller: "users", action: "show", id: "1"
  end

  test "invalid user should redirect to new" do
    post users_url, params: @@invalid_user_params 
    assert_redirected_to controller: "users", action: "new"
  end
end
