class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required!
  before_action :find_question, only: %i[new create]
  before_action :set_answer, only: %i[show]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer
    else
      render :new
    end
  end
  private

  def admin_required!
    redirect_to root_path, alert: 'You are not authorized to view this page!' unless current_user.is_a?(Admin)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end
end
