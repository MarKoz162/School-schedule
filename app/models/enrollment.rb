class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :user_id, scpoe: :course_id
  validates_uniqueness_of :course_id, scpoe: :user_id
  validate :can_not_be_enrolled_in_own_course

  def can_not_be_enrolled_in_own_course
    if user_id.present?
      if user_id == course.user_id
        erros.add(:user_id, "can't enrolled in own course")
      end
    end
  end

  def to_s
    id
  end

end