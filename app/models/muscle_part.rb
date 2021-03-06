# ユーザーの各部位の状態を表すモデル
class MusclePart < ApplicationRecord
  before_save :set_recovery_span
  before_create :set_last_date
  belongs_to :user
  belongs_to :part

  validates :part_id, uniqueness: { scope: :user_id }

  # 対象部位が回復しているか確認
  def is_recovered(current_time)
    days_since_last_date = current_time - self.last_date
    if days_since_last_date >= self.recovery_span
      return true
    else
      return false
    end
  end

  private

    def set_last_date
      self.last_date = 1.year.ago.to_date
    end

    # 部位(part)に応じて回復期間を予めセットする
    def set_recovery_span
      case self.part.name
        when "脚", "背筋", "広背筋", "ハムストリング", "大腿四頭筋"
          self.recovery_span = 3
        when "上腕二頭筋", "上腕三頭筋", "大胸筋", "ヒップ", "肩"
          self.recovery_span = 2
      end
    end
end
