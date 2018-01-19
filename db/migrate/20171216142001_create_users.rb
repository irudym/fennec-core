class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :sign_in_count, default: 0, null: false
      t.timestamps
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
