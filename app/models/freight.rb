class Freight < ApplicationRecord
  validates :state, :weight_min, :weight_max, :cost, presence: true

  def self.weight_range(weight)
    where('weight_min <= :weight AND weight_max >= :weight', weight: weight)
  end
end
