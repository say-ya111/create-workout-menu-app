class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.references :user, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
    add_index :menus, [:user_id, :type_id], unique: true
  end
end
