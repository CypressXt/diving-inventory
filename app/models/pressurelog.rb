class Pressurelog < ApplicationRecord
  validates :pressure_start, :pressure_end, :o2_percentage,
    numericality: {only_integer: true, greater_than_or_equal_to: 0},
    allow_nil: true
  validates :o2_percentage, numericality: {less_than_or_equal_to: 100},
    allow_nil: true
  validates :tank, presence: true
  belongs_to :tank
end
