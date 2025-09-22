class OverallPicksController < ApplicationController
  before_action :require_login
  before_action :set_season
  before_action :set_overall_pick
  before_action :set_contestants

  def new
    redirect_to edit_season_overall_pick_path(@season, @overall_pick) if @overall_pick.persisted?
  end

  def create
    @overall_pick.assign_attributes(overall_pick_params)

    if @overall_pick.save
      redirect_to season_path(@season), notice: "Overall winner pick saved!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @overall_pick.update(overall_pick_params)
      redirect_to season_path(@season), notice: "Overall winner pick updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_season
    @season = Season.find(params[:season_id])
  end

  def set_overall_pick
    @overall_pick = OverallPick.find_or_initialize_by(season: @season, user: current_user)
  end

  def set_contestants
    @contestants = contestants_for(@season)
  end

  def overall_pick_params
    params.require(:overall_pick).permit(:winner_id)
  end
end
