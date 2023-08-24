class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :username
      t.string :email
      t.integer :phone_number
      t.string :password_digest
      t.string :password_reset_token, null: true

      t.timestamps
    end
  end
end
