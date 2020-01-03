class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :type
  validates :user_id, presence: true
  validates :type_id, presence: true
end
