class CreatePuppies < ActiveRecord::Migration[5.0]
  def change
    create_table :puppies do |t|
      t.string :name, null: false
      t.integer :stomach, null: false, default: 10
      t.integer :bladder, null: false, default: 0
      t.integer :bowel, null: false, default: 0
      t.boolean :bored, null: false, default: false

      t.timestamps
    end
  end
end
