class Classroom < ApplicationRecord

  has_many :course, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def to_s
    name
  end
  
end
