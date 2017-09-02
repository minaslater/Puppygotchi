require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new (log in page)" do
    get new_session_path
    assert_response :success
  end

  test "valid user should redirect to profile" do
    post sessions_path, params: { email: "123@456.com", password: "welcome" }
    assert_redirected_to controller: "users", action: "show", id: users(:test_user).id
  end

  test "valid user should set session cookie" do
    post sessions_path, params: { email: "123@456.com", password: "welcome" }
    assert_equal users(:test_user).id, session[:user_id]
  end

  test "user with incorrect password should redirect back to login" do
    post sessions_path, params: { email: "123@456.com", password: "chicken" }
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "user with incorrect password should result in error message" do
    post sessions_path, params: { email: "123@456.com", password: "chicken" }
    assert_equal "something", flash[:alert]
  end

  test "invalid email should redirect back to login" do
    post sessions_path, params: { email: "456@123.com", password: "welcome" }
    assert_redirected_to controller: "sessions", action: "new"
  end

  test "invalid email should result in error message" do
    post sessions_path, params: { email: "456@123.com", password: "welcome" }
    assert_equal "email/password combination does not match", flash[:alert]
  end
end

