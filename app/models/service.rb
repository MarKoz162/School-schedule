class Service < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :duration, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  validates :client_price, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}

  def to_s
    name
  end

end
