class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :status, presence: true

  validates_uniqueness_of :user_id, scpoe: :lesson_id
  validates_uniqueness_of :lesson_id, scpoe: :user_id

  validate :can_not_attende_in_own_course_or_lesson

  def can_not_attende_in_own_course_or_lesson
    if user_id.present?
      if user_id == lesson.user_id || user_id == lesson.course.user_id
        erros.add(:user_id, "can't can not attende in own course or lesson")
      end
    end
  end

  STATUSES = [:planned, :attended, :not_attended]

  def self.statuses
    STATUSES.map { |status| [status, status] }
  end

  def to_s
    user
  end

end
