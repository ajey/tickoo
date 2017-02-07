class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.integer :customer_id
      t.integer :agent_id
      t.string :status
      t.string :category

      t.timestamps
    end
  end
end
