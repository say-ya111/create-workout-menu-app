class Part < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :muscle_parts
  has_many :types

  def self.upper_parts
    ["大胸筋", "背筋", "広背筋", "上腕二頭筋", "腹筋"]
  end

  def self.lower_parts
    ["脚", "ハムストリング", "大腿四頭筋", "カーフ", "ヒップ"]
  end
end
