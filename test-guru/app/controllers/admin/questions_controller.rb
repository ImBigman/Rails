class Admin::QuestionsController <  Admin::BaseController
  before_action :find_test, only: %i[index new]
  before_action :find_questions, only: %i[show edit]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_questions_not_found

  def index; end

  def show;  end

  def new
    @question = Question.new
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_questions
    @question = Question.find(params[:id])
  end

  def rescue_with_questions_not_found
    render plain: 'Question was not found!'
  end
end
