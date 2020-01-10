class TestsController < ApplicationController
  before_action :authenticate_user!, only: %i[start index]
  before_action :find_test, only: %i[show start]
  before_action :user_signed_in?

  def index
    @tests = Test.all
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end
end
