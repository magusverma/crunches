class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_filter :login_check, :except => [:login]

  # GET /submissions
  # GET /submissions.json
  def index
    check_admin
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @u = User.find(session[:user])
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)
    @submission.time_of_submission = Time.now
    @submission.ip = request.remote_ip
    @submission.user = User.find(session[:user]) #todo
    if @submission.submitted_answer.eql? @submission.question.answer
      @submission.status = :correct
    else
      @submission.status = :wrong
    end  
    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    # respond_to do |format|
    #   if @submission.update(submission_params)
    #     format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @submission }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @submission.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    # @submission.destroy
    # respond_to do |format|
    #   format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      #:status,:user_id,:time_of_submission, :ip
      params.require(:submission).permit(:question_id,:submitted_answer)
    end
end
