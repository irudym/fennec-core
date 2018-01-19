class ChangeTrashAndPrivateAtDevices < ActiveRecord::Migration[5.1]
  def change
    remove_column :devices, :trash
    remove_column :devices, :private
    add_column :devices, :trash, :boolean, default: false
    add_column :devices, :private, :boolean, default: true
  end
end
