class QuestionsController < ApplicationController
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_questions_not_found

  private

  def rescue_with_questions_not_found
    render plain: 'Question was not found!'
  end
end
