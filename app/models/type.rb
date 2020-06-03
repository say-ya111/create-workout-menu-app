class Type < ApplicationRecord
  has_many :menus
  belongs_to :part

  validates :name, presence: true
  validates :part_id, presence: true
end
