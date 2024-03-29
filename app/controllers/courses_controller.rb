class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy generate_lessons ]

  
  def index
    @courses = Course.all
  end

  def znajdz
    @courses = Course.where(user_id: 12)
  end

  def generate_lessons

    @course.lessons.where("start > ?" , Time.now).destroy_all

    @course.schedule.next_occurrences(8).each do |oc|
      @course.lessons.find_or_create_by(start: oc, user: @course.user, classroom: @course.classroom)
    end

    @course.lessons.where("start > ?" , Time.now).each do |lesson|
      @course.enrollments.each do |enrollment|
        lesson.attendances.find_or_create_by(status: "planned", user: enrollment.user)
      end
    end
    redirect_to @course
  end

  def show
    @lessons = @course.lessons
    @enrollments = @course.enrollments
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:user_id, :classroom_id,
        :service_id, :start_time, *Course::DAYS_OF_WEEK,
        enrollments_attributes: [:id, :user_id, :_destroy])
    end
end
