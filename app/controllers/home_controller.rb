class HomeController < ApplicationController
  def index
    
  end

  def calendar
    @users = User.all.order(email: :asc)
    @classrooms = Classroom.all.order(name: :asc)
    @courses = Course.all.order(id: :desc)

    if params.has_key?(:user_id)
      lessons = Lesson.includes(:user, :classroom, :course, :attendances)
      if params[:user_id].present?
        @user = params[:user_id]
        lessons = lessons.where(user_id: params[:user_id])
      end
      if params[:classroom_id].present?
        @classroom = params[:classroom_id]
        lessons = lessons.where(classroom_id: params[:classroom_id])
      end
      if params[:course_id].present?
        @course = params[:course_id]
        lessons = lessons.where(course_id: params[:course_id])
      end
      @lessons = lessons.all
    else
      @lessons = Lesson.includes(:user, :classroom, :course, :attendances)
    end
  end
end
