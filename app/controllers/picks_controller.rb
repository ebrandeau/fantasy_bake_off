class PicksController < ApplicationController
  before_action :require_login
  before_action :set_season
  before_action :set_episode
  before_action :set_existing_pick, only: %i[new create]
  before_action :set_pick, only: %i[edit update destroy]
  before_action :authorize_pick!, only: %i[edit update destroy]
  before_action :set_form_collections, only: %i[new create edit update]

  def new
    return redirect_to edit_season_episode_pick_path(@season, @episode, @existing_pick) if @existing_pick&.persisted?

    @pick = @existing_pick
  end

  def edit; end

  def create
    @pick = @existing_pick
    @pick.assign_attributes(pick_params)
    @pick.user = current_user

    if @pick.save
      redirect_to season_episode_path(@season, @episode), notice: "Weekly pick saved!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @pick.update(pick_params)
      redirect_to season_episode_path(@season, @episode), notice: "Weekly pick updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pick.destroy
    redirect_to season_episode_path(@season, @episode), notice: "Pick removed.", status: :see_other
  end

  private

  def set_season
    @season = Season.find(params[:season_id])
  end

  def set_episode
    @episode = @season.episodes.find(params[:episode_id])
  end

  def set_pick
    @pick = @episode.picks.find(params[:id])
  end

  def set_existing_pick
    @existing_pick = @episode.picks.find_or_initialize_by(user: current_user)
  end

  def authorize_pick!
    return if admin? || @pick.user == current_user

    redirect_to season_episode_path(@season, @episode), alert: "You can only manage your own picks."
  end

  def set_form_collections
    @contestants = contestants_for(@season)
  end

  def pick_params
    params.require(:pick).permit(:star_baker_id, :technical_winner_id, :handshake_id)
  end
end
