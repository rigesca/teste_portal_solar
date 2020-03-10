class PowerGenerator < ApplicationRecord
  before_create :calculate_cubage
  before_update :calculate_cubage

  validates :name, :description, :image_url, :manufacturer, :price, :kwp, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }
  validates :width, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :lenght, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3000 }
  validates :cubage, numericality: { greater_than_or_equal_to: 0 }

  enum structure_type: %i[
    metalico
    ceramico
    fibrocimento
    laje
    solo
    trapezoidal
  ]

  paginates_per 6

  def self.name_description_search(word)
    word = "%#{word.upcase}%"
    where('UPPER(name) LIKE :word OR UPPER(description) LIKE :word', word: word)
  end

  def self.ranged_sql_where(campo, minimum, maximum)
    return where("#{campo} >= #{maximum}") if minimum.blank?

    return where("#{campo} <= #{minimum}") if maximum.blank?

    where("#{campo} BETWEEN #{minimum} AND #{maximum}")
  end

  def self.order_search(order)
    case order.to_i
    when 1
      order(:price)
    when 2
      order(price: :desc)
    when 3
      order(:kwp)
    when 4
      order(kwp: :desc)
    else
      order(:name)
    end
  end

  def lowest_weight
    return weight if weight < cubage

    return cubage
  end

  private

  def calculate_cubage
    return self.cubage = 0 if height.zero? && width.zero? && lenght.zero?

    self.cubage = height * width * lenght * 300
  end
end
