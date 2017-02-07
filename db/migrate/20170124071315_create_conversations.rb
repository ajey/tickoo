class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.text :message
      t.integer :ticket_id
      t.integer :user_id

      t.timestamps
    end
  end
end
