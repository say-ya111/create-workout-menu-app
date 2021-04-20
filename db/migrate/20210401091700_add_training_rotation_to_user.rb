class AddTrainingRotationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :training_rotation, :integer, {default: 0, after: :email}
  end
end
