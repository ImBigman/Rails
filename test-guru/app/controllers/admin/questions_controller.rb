class Admin::QuestionsController <  Admin::BaseController
  before_action :authenticate_user!
  before_action :admin_required!
  before_action :find_test, only: %i[index new]
  before_action :find_questions, only: %i[show edit]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_questions_not_found

  def index; end

  def show;  end

  def new
    @question = Question.new
  end

  private

  def admin_required!
    redirect_to root_path, alert: 'You are not authorized to view this page!' unless current_user.is_a?(Admin)
  end

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
