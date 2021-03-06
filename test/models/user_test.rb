require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Mina", email: "user@expamle.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "should accept valid addresses" do
    valid_addresses = %w[user@example.com USERS@eXamples.com a_user@puppy.com first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be accepted."
    end
  end

  test "should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user-at-puppy.co puppy@user. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be rejected."
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emails should be saved as lower case" do
    mixed_case_email = "uSeR@eXamPle.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "should add friend with make_friend_with" do
    aji = users(:test_user)
    jeremy = users(:test_user3) 
    jeremy.make_friends_with(aji)
    assert_equal aji, jeremy.friend_ones.first
  end

  test "should remove friendship with delete_friend" do
    aji = users(:test_user)
    jeremy = users(:test_user3) 
    jeremy.make_friends_with(aji)
    aji.delete_friend(jeremy)
    assert_empty aji.friends
  end

  test "should delete friendships when user is deleted" do
    aji = users(:test_user)
    jeremy = users(:test_user3) 
    jeremy.make_friends_with(aji)
    aji.destroy
    friendships = [Friendship.where(friend_one_id: aji.id, friend_two_id: jeremy.id), Friendship.where(friend_one_id: aji.id, friend_two_id: jeremy.id)]
    assert_equal 0, friendships[0].length
    assert_equal 0, friendships[1].length
  end

  test "should verify friendship with method" do
    aji = users(:test_user)
    mina = users(:test_user2)
    aji.make_friends_with(mina)
    assert mina.verify_friendship?(aji)
  end
end

