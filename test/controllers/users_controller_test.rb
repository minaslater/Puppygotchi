require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    before_count = User.count
    post users_url, params: { user: { name: "Aji", email: "user@example.com", password: "foobar", password_confirmation: "foobar" } }
    assert_equal before_count + 1, User.count 
  end

  test "should not create user with incorrect params" do
    before_count = User.count
    post users_url, params: { user: { hair_color: "blue", species: "duck" } }
    assert_equal before_count, User.count
  end
end
