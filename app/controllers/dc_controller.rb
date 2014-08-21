class DcController < ApplicationController
  before_filter :authorize, :except => [:login]
  def leaderboard
  end

  def rules
  end

  def login
    
    if !session[:user].nil?
      redirect_to "/leaderboard"
    else
      @user = User.new
      respond_to do |format|
        format.html {render :layout => 'nonlogin'}
      end
    end
  end

  def about
  end

  def question
    @q = Question.find(params[:id])
    @submission = Submission.new
    @user = User.find(session[:user])
  end

  def theme
    @t = Theme.where(name: params[:id])[0]
  end

  def register
    @user = User.find(session[:user])#User.first #todo 
  end

  def authorize
    if session[:user].nil?
      redirect_to "/login"
    end
  end
  def clear
    session[:user] = nil
    redirect_to "/login"
  end
end
