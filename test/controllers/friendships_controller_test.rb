require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @aji = users(:test_user)
    @jeremy = users(:test_user3)
  end
  # test friendships#create
  test "should create friendship" do
    login_test_user(@aji)
    before_count = @aji.friends.count
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_equal before_count + 1, User.find(@aji.id).friends.count
  end

  test "should not create friendship if not logged in" do
    before_count = @aji.friends.count
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_equal before_count, User.find(@aji.id).friends.count  
  end

  test "should have correct flash message on success" do
    login_test_user(@aji)
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_equal "Congrats! You are now friends with Jeremy.", flash[:notice]
  end

  test "should redirect to own profile" do
    login_test_user(@aji)
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_redirected_to user_path(@aji.id)
  end

  test "should have correct flash alert if not logged in" do
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_equal "Please log in", flash[:alert]
  end

  test "should redirect to root if not logged in" do
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_redirected_to root_path
  end

  test "should have correct flash alert if already friends" do
    login_test_user(@aji)
    @aji.make_friends_with(@jeremy)
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_equal "You are already friends!", flash[:alert]
  end

  test "should redirect to own profile if already friends" do
    login_test_user(@aji)
    @aji.make_friends_with(@jeremy)
    post users_friendships_url, params: { user_id: @jeremy.id, id: @aji.id }
    assert_redirected_to user_path(@aji.id)
  end

  # test frienships#destroy
  test "should destroy a friendship if logged in" do
    login_test_user(@aji)
    before_count = @aji.friends.count
    @aji.make_friends_with(@jeremy)
    delete users_friendship_url(@jeremy.id) 
    assert_equal before_count, User.find(@aji.id).friends.count
  end

  test "should add flash notice if destroyed" do
    login_test_user(@aji)
    before_count = @aji.friends.count
    @aji.make_friends_with(@jeremy)
    delete users_friendship_url(@jeremy.id) 
    assert_equal "Successfully unfriended", flash[:notice] 
  end
  
  test "should redirect to own profile if destroyed" do
    login_test_user(@aji)
    before_count = @aji.friends.count
    @aji.make_friends_with(@jeremy)
    delete users_friendship_url(@jeremy.id) 
    assert_redirected_to user_path(@aji.id) 
  end
  
  test "should not destroy a friendship if not logged in" do
    login_test_user(@aji)
    before_count = @aji.friends.count
    @aji.make_friends_with(@jeremy)
    logout_test_user(@aji)
    delete users_friendship_url(@jeremy.id) 
    assert_equal before_count + 1, User.find(@aji.id).friends.count 
  end

  test "should add flash alert if not logged in" do
    login_test_user(@aji)
    before_count = @aji.friends.count
    @aji.make_friends_with(@jeremy)
    logout_test_user(@aji)
    delete users_friendship_url(@jeremy.id) 
    assert_equal "Action not permitted.", flash[:alert]
  end

  test "should redirect to root on destroy if not logged in" do
    login_test_user(@aji)
    before_count = @aji.friends.count
    @aji.make_friends_with(@jeremy)
    logout_test_user(@aji)
    delete users_friendship_url(@jeremy.id) 
    assert_redirected_to root_path
  end
end
