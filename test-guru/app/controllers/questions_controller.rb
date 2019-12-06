class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create]
  before_action :find_questions, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_questions_not_found

  def index
    render inline: '<p> Все вопросы "<%= @test.title %>" теста: <%= @test.questions.pluck(:body).join(", ") %> </p>'
  end

  def show
    render inline: '<p>Что вы можете рассказать о <%= @question.body %>, в контексте <%= @question.test.title %>?</p>'
  end

  def new; end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to test_questions_path
    else
      render 'new'
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_questions
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_questions_not_found
    render plain: 'Question was not found!'
  end
end
