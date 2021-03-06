class ExamsController < ApplicationController
  before_action :check_permission
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.all
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
   @questions = Question.where(:exam_id => params[:id])
         
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    5.times do
      question = @exam.questions.build
      4.times { question.answers.build }
      end
  end

 #for students 

  def student
     @exam = Exam.all.paginate( :page => params[:page], :per_page => 1)
    @page = params[:page]
  end

#for marks


  def marks

  @page=params[:page]
   if params[:exam]
     @marks = []
     params[:exam].each do |x|
       @marks << 1 if Question.find(x[0]).correct_answer == Answer.find(x[1]["answer_id"]).content
     end
     @marks = @marks.inject(:+)
   end
    end


  # GET /exams/1/edit
  def edit
  end

  # POST /exams  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:name, questions_attributes: [:content, :correct_answer, answers_attributes: [:content]])
    end

end
