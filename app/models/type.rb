class Type < ApplicationRecord
  has_many :menus
  belongs_to :part

  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validates :part_id, presence: true
end
