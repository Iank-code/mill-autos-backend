class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :email
      t.integer :phone_namber
      t.string :password_digest

      t.timestamps
    end
  end
end
