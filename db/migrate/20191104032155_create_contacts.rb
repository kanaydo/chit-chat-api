class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
