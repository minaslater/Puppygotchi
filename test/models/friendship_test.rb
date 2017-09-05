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

  test "should not create new friendship if duplicate" do
    @mina.friendship_one.create(friend_one_id: @aji.id)
    assert_equal 0, @mina.friend_ones.count
  end
end
