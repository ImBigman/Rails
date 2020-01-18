class Admin::BadgesController < Admin::BaseController
  before_action :find_badge, only: %i[destroy show]

  def show; end

  def new
    @badge = Badge.new
  end

  def index
    @badges = Badge.all
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to admin_badges_path, notice: t('badges.success')
    else
      render new
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def badge_params
    params.require(:badge).permit(:name, :url, :kind)
  end

  def find_badge
    @badge = Badge.find(params[:id])
  end
end

