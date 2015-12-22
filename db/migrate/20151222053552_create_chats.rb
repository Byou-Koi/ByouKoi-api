class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :message
      t.integer :user_id
      t.integer :room_id
      t.timestamps null: false
    end
  end
end
