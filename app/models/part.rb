class Part < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :muscle_parts
  has_many :types

  ALL_PARTS = ["大胸筋", "背筋", "広背筋", "上腕二頭筋", "上腕三頭筋", "脚", "ハムストリング", "大腿四頭筋", "ヒップ", "肩"]

  def self.upper_parts
    ["大胸筋", "背筋", "広背筋", "上腕二頭筋", "上腕三頭筋" "肩"]
  end

  def self.lower_parts
    ["脚", "ハムストリング", "大腿四頭筋", "ヒップ"]
  end

  def self.push_parts
    ["大胸筋", "肩", "上腕三頭筋"]
  end

  def self.pull_parts
    ["背筋", "広背筋", "上腕二頭筋"]
  end

  def self.back_parts
    ["背筋", "広背筋"]
  end

  # 一部位しかないけど、胸筋上部とかを追加した時の拡張性を考慮
  def self.chest_parts
    ["大胸筋"]
  end

  def self.shoulder_parts
    ["肩"]
  end

  def self.arm_parts
    ["上腕三頭筋", "上腕二頭筋"]
  end
end
