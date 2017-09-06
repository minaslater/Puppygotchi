require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup  
    @aji = users(:test_user)
    @mina = users(:test_user2)
    @aji.friendship_one.create(friend_one_id: @mina.id)
  end
    
  test "should be able to add friends" do
    assert_equal @aji.friend_ones.first, @mina
    assert_equal @mina.friend_twos.first, @aji
  end

  test "should not create new friendship if combination is same" do
    @mina.friendship_two.create(friend_two_id: @aji.id)
    assert_equal 1, @mina.friend_twos.count
  end

  test "should not create new friendship if duplicate" do
    @mina.friendship_one.create(friend_one_id: @aji.id)
    assert_equal 0, @mina.friend_ones.count
  end

  test "should add friend with make_friend_with" do
    jeremy = users(:test_user3) 
    jeremy.make_friends_with(@aji)
    assert_equal @aji, jeremy.friend_ones.first
  end
end
