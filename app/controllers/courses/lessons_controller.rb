class Courses::LessonsController < ApplicationController
  before_action :set_course, except: %i[edit destroy]
  before_action :set_lesson, only: %i[ show edit update destroy ]

  
  # GET /lessons/new
  def new
    @lesson = Lesson.new(classroom_id: @course.classroom_id, user_id: @course.user)
    @lesson.attendances.build(@course.enrollments.as_json(only: [:user_id]))
  end

  # GET /lessons/1/edit
  def edit
    @lesson = Lesson.find(params[:course_id])
    @course = Course.find(params[:id])
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.course = @course

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @course, notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @course, notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:course_id])
    @course = Course.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to @course, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:user_id, :classroom_id, :course_id, :status, :start,
        attendances_attributes: [:id, :user_id, :_destroy])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end
end
