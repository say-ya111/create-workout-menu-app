class Part < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :muscle_parts
  has_many :types

  def upper_parts
    ["大胸筋", "背筋", "広背筋", "上腕二頭筋"]
  end

  def lower
    ["脚", "ハムストリング", "大腿四頭筋", "カーフ"]
  end
end
