class AddUserIdToPuppies < ActiveRecord::Migration[5.0]
  def change
    add_column :puppies, :user_id, :integer
    add_foreign_key :puppies, :users
  end
end
