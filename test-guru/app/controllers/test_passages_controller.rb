class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show result update gist]

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call
    new_gist = Gist.new(question_id: @test_passage.current_question.id, question_body: @test_passage.current_question.body, url: result.url, user: current_user.email)
    new_gist.save
    flash_options = if result.nil?
                      { alert: t('.failure') }
                    else
                      { notice: t('.success') + " Gist: #{result.html_url}" }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
