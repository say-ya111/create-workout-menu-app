class MusclePart < ApplicationRecord
  before_save :set_last_date, :set_recovery_span
  belongs_to :user

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

    def set_recovery_span
      case self.part
        when "大胸筋"
          self.recovery_span = 2
        when "足"
          self.recovery_span = 3
        when "背筋"
          self.recovery_span = 3
        when "広背筋"
          self.recovery_span = 3
        when "上腕二頭筋"
          self.recovery_span = 2
      end
    end
end
