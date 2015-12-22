class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :user_id
      t.integer :lover_id
      t.string :auth_token
      t.timestamps null: false
    end
  end
end
