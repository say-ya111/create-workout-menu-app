class Part < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :muscle_parts
  has_many :types
end
