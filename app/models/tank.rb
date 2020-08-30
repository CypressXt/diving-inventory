class Tank < ApplicationRecord
  validates :tank_number, uniqueness: true
  validates :tank_number, :volume, numericality: { only_integer: true }
  validates :tank_number, :volume, presence: true

  has_many :pressurelogs, dependent: :destroy

  def is_filled
    is_filled = false
    pressurelog = self.pressurelogs.order("updated_at DESC").first
    if pressurelog != nil and pressurelog.pressure_start.presence and !pressurelog.pressure_end.presence
      is_filled = true
    end
    return is_filled
  end

  def get_current_log
    pressurelog = self.pressurelogs.order("updated_at DESC").first
  end
end
