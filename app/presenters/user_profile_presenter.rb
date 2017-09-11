class UserProfilePresenter
  def initialize(current_user, user, view_context)
    @current_user = current_user
    @user = user
    @v = view_context
  end

  def display_profile_options
    unless @current_user
      add_friend_link
    end
    if @current_user == @user
      edit_user_link + delete_user_link
    elsif @current_user.verify_frienship(@user)
      remove_friend_link
    else
      add_friend_link
    end
  end

  private
    
    def edit_user_link
      @v.content_tag :li, class: "user-profile__controls--link" do
        @v.link_to "Edit User", @v.edit_user_path(@user.id) 
      end
    end

    def delete_user_link
      @v.content_tag :li, class: "user-profile__controls--link" do
        @v.link_to "Delete User", @v.user_path(@user.id), method: :delete, data: { confirm: "Are you sure?" } 
      end
    end

    def add_friend_link
      @v.content_tag :li, class: "user-profile__controls--link" do
        @v.link_to "Add Friend", @v.users_friendships_path(user_id: @user.id), method: :post  
      end
    end

    def remove_friend_link
      @v.content_tag :li, class: "user-profile__controls--link" do
        @v.link_to "Remove Friend", @v.users_friendship_path(user_id: @current_user.id, id: @user.id), method: :delete, data: { confirm: "Are you sure?" }
      end
    end
end
