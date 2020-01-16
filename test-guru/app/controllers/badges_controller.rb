class BadgesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[create]

  def index
    @badges = current_user.badges
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = @test_passage.user.badges.new(badge_params)

    redirect_to result_test_passage_path(@test_passage) if @badge.save
  end

  private

  def badge_params
    params.require(:badge).permit(:name, :url)
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end

