class Tank < ApplicationRecord
  validates :tank_number, uniqueness: true
  validates :tank_number, :volume, numericality: { only_integer: true }
  validates :tank_number, :volume, presence: true
end
