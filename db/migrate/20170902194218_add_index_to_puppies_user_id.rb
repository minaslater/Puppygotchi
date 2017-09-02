class AddIndexToPuppiesUserId < ActiveRecord::Migration[5.0]
  def change
    add_index :puppies, :user_id
  end
end
