class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.text :secret
      t.string :MAC
      t.boolean :private
      t.boolean :trash
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
