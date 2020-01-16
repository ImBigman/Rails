class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show result update gist progress]

  def show; end

  def result
    @test_passage.success? ? @test_passage.update(completed: false) : @test_passage.update(completed: true)
    first_clear_passage
    badge_by_category(@test_passage.test.category.title)
    by_level(@test_passage.test.level)
  end

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

  def first_clear_passage
    return unless @test_passage.first_time && @test_passage.completed == true

    @test_passage.user.badges.create(
      name: t('badges.first_time', test: @test_passage.test.title),
      url: "<svg height='24' class='octicon octicon-star mr-2 text-success' viewBox='0 0 14 16' version='1.1' width='21' aria-hidden='true'><path fill-rule='evenodd' d='M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74L14 6z'/></svg>",
      test_passage_id: @test_passage.id
    )
  end

  def badge_by_category(category)
    unless @test_passage.badge_by(category) && @test_passage.completed == true
      return
    end

    @test_passage.user.badges.create(
      name: t('badges.by_category', category: @test_passage.test.category.title),
      url: "<svg height='24' class='octicon octicon-repo-template mr-2 text-primary' viewBox='0 0 14 16' version='1.1' width='21' aria-hidden='true'><path fill-rule='evenodd' d='M12 8V1c0-.55-.45-1-1-1H1C.45 0 0 .45 0 1v12c0 .55.45 1 1 1h2v2l1.5-1.5L6 16v-4H3v1H1v-2h7v-1H2V1h9v7h1zM4 2H3v1h1V2zM3 4h1v1H3V4zm1 2H3v1h1V6zm0 3H3V8h1v1zm6 3H8v2h2v2h2v-2h2v-2h-2v-2h-2v2z'/></svg>",
      test_passage_id: @test_passage.id
    )
  end

  def by_level(level)
    unless @test_passage.badge_by_level(level) && @test_passage.completed == true
      return
    end

    @test_passage.user.badges.create(
      name: t('badges.by_level', level: @test_passage.test.level),
      url: "<svg height='24' class='octicon octicon-rocket mr-2 text-danger' viewBox='0 0 16 16' version='1.1' width='24' aria-hidden='true'><path fill-rule='evenodd' d='M12.17 3.83c-.27-.27-.47-.55-.63-.88-.16-.31-.27-.66-.34-1.02-.58.33-1.16.7-1.73 1.13-.58.44-1.14.94-1.69 1.48-.7.7-1.33 1.81-1.78 2.45H3L0 10h3l2-2c-.34.77-1.02 2.98-1 3l1 1c.02.02 2.23-.64 3-1l-2 2v3l3-3v-3c.64-.45 1.75-1.09 2.45-1.78.55-.55 1.05-1.13 1.47-1.7.44-.58.81-1.16 1.14-1.72-.36-.08-.7-.19-1.03-.34a3.39 3.39 0 01-.86-.63zM16 0s-.09.38-.3 1.06c-.2.7-.55 1.58-1.06 2.66-.7-.08-1.27-.33-1.66-.72-.39-.39-.63-.94-.7-1.64C13.36.84 14.23.48 14.92.28 15.62.08 16 0 16 0z'/></svg>",
      test_passage_id: @test_passage.id
    )
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
