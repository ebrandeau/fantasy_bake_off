class EpisodesController < ApplicationController
  before_action :require_login
  before_action :set_season
  before_action :set_episode, only: %i[show edit update destroy]
  before_action :set_contestants, only: %i[new edit create update]
  before_action :require_admin, except: %i[index show]

  def index
    @episodes = @season.episodes.order(:number)
  end

  def show
    @contestants = contestants_for(@season)
    @result = @episode.result
    @picks = @episode.picks.includes(:user)
    @user_pick = @episode.picks.find_by(user: current_user)
  end

  def new
    @episode = @season.episodes.new
  end

  def edit; end

  def create
    @episode = @season.episodes.new(episode_params)

    if @episode.save
      redirect_to [@season, @episode], notice: "Episode created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @episode.update(episode_params)
      redirect_to [@season, @episode], notice: "Episode updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @episode.destroy
    redirect_to season_episodes_path(@season), notice: "Episode removed.", status: :see_other
  end

  private

  def set_season
    @season = Season.find(params[:season_id])
  end

  def set_episode
    @episode = @season.episodes.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:number, :air_date, :star_baker_id, :technical_winner_id, :handshake_id, :eliminated_id)
  end

  def set_contestants
    @contestants = contestants_for(@season)
  end
end
