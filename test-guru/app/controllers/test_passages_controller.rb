class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show result update gist progress]

  def show; end

  def result
    @test_passage.success? ? @test_passage.update(completed: false) : @test_passage.update(completed: true)
    return unless @test_passage.completed == true

    award = BadgeService.new(@test_passage)
    award.call
  end

  def update
    overtime
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    connection = GistQuestionService.new(@test_passage.current_question)
    result = connection.call

    if connection.success?
      current_user.gists.create(question_id: @test_passage.current_question.id, url: result.html_url)
      flash_options = { notice: t('.success') + " Gist: #{result.html_url}" }
    else
      flash_options = { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  def overtime
    return unless @test_passage.check_timer

    redirect_to(result_test_passage_path(@test_passage)) && (return)
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
