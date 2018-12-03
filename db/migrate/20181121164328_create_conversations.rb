class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :name
      t.integer :user_id
      t.string :password

      t.timestamps
    end
  end
end
