class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :times_a_week, :integer, default: 2
  end
end
