class BadgesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_badge, only: %i[show]

  def index
    @badges = Badge.all
    @test_passages = TestPassage.all.where(user_id: current_user.id).joins(:badges)
  end

  private

  def find_badge
    @badge = Badge.find(params[:id])
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end

