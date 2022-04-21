class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :user_id, scpoe: :course_id
  validates_uniqueness_of :course_id, scpoe: :user_id


  def to_s
    id
  end

end