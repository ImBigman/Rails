class Admin::BadgesController < Admin::BaseController
  before_action :find_badge, only: %i[destroy show]

  def show; end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def find_badge
    @badge = Badge.find(params[:id])
  end
end

