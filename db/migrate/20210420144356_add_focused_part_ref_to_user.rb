class AddFocusedPartRefToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :focused_part, foreign_key: { to_table: :parts }
  end
end
