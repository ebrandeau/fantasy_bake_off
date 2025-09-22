class SeasonsController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: %i[index show leaderboard]
  before_action :set_season, only: %i[show edit update destroy leaderboard]

  def index
    @seasons = Season.order(year: :desc)
  end

  def show
    @episodes = @season.episodes.order(:number)
    @contestants = contestants_for(@season)
    @overall_pick = OverallPick.find_by(season: @season, user: current_user)
  end

  def new
    @season = Season.new
  end

  def edit; end

  def create
    @season = Season.new(season_params)

    if @season.save
      redirect_to @season, notice: "Season created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @season.update(season_params)
      redirect_to @season, notice: "Season updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @season.destroy
    redirect_to seasons_path, notice: "Season removed.", status: :see_other
  end

  def leaderboard
    user_ids = Pick.joins(:episode).where(episodes: { season_id: @season.id }).distinct.pluck(:user_id)
    user_ids |= OverallPick.where(season: @season).distinct.pluck(:user_id)

    @leaderboard = user_ids.map do |uid|
      user = User.find(uid)
      { user:, points: ScoreCalculator.user_points(user:, season: @season) }
    end.sort_by { |row| -row[:points] }
  end


  private

  def set_season
    @season = Season.find(params[:id])
  end

  def season_params
    params.require(:season).permit(:year, :active, :winner_contestant_id)
  end
end
