class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_filter :login_check, :except => [:login]
  def subsequence(s1, s2)
      match = 0.0
      deno = 1

          return 0 if s1.empty? || s2.empty?
    if s2.size < 2000
        s1 = s1.gsub(/[^0-9a-z]/i, '').downcase
        s2 = s2.gsub(/[^0-9a-z]/i, '').downcase
        deno = [s1.size,s2.size].max
          num=Array.new(s1.size){Array.new(s2.size)}
          s1.scan(/./).each_with_index{|letter1,i|
              s2.scan(/./).each_with_index{|letter2,j|
   
                      if s1[i]==s2[j]
                          if i==0||j==0
                             num[i][j] = 1
                          else
                             num[i][j]  = 1 + num[i - 1][ j - 1]
                          end
                      else
                          if i==0 && j==0
                             num[i][j] = 0
                          elsif i==0 &&  j!=0  #First ith element
                             num[i][j] = [0,  num[i][j - 1]].max
                          elsif j==0 && i!=0  #First jth element
                              num[i][j] = [0, num[i - 1][j]].max
                          elsif i != 0 && j!= 0
                            num[i][j] = [num[i - 1][j], num[i][j - 1]].max
                          end
                      end
              }
          }
          
        match +=  num[s1.length - 1][s2.length - 1]
      end 
      return match/deno
  end

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
    # if @submission.submitted_answer.eql? @submission.question.answer
    if @submission.question.qtype.eql? "" or @submission.question.qtype.eql? nil    
      if @submission.submitted_answer.gsub(/[^0-9a-z]/i, '').downcase.eql? @submission.question.answer.gsub(/[^0-9a-z]/i, '').downcase
        # @submission.points = @submission.question.points #todo
        @submission.status = :correct
      else
        # @submission.points = 0 #todo
        @submission.status = :wrong
      end 
    elsif @submission.question.qtype.eql? "sub"
      s1 = @submission.question.answer
      s2 = @submission.submitted_answer
      @submission.points = subsequence(s1,s2)*@submission.question.points
      @submission.points = @submission.points.round(2)
      if @submission.points > 0
        @submission.status = :correct
      else
        @submission.status = :wrong
      end 
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
