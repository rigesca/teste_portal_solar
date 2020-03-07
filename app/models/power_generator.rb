class PowerGenerator < ApplicationRecord
  before_create :calculate_cubage

  validates :name, :description, :image_url, :manufacturer, :price, :kwp, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }
  validates :width, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :lenght, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3000 }
  validates :cubage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3000 }

  enum structure_type: %i[
    metalico
    ceramico
    fibrocimento
    laje
    solo
    trapezoidal
  ]

  def self.word_search(word)
    word = "%#{word.upcase}%"
    where('UPPER(name) LIKE :word OR UPPER(description) LIKE :word', word: word)
      .order(:name, :price)
  end

  private

  def calculate_cubage
    return 0 if height.zero? && width.zero? && lenght.zero?

    self.cubage = height * width * lenght * 300
  end
end
