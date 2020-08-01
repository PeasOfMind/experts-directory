class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :member, null: false, index: true, foreign_key: true
      t.references :friend, null: false, index: true

      t.timestamps
    end

    add_foreign_key :friendships, :members, column: :friend_id
    add_index :friendships, [:member_id, :friend_id], unique: true
  end
end
