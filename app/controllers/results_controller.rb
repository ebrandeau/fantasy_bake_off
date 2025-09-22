class ResultsController < ApplicationController
  before_action :require_login
  before_action :set_season
  before_action :set_episode
  before_action :set_result, only: %i[show edit update]
  before_action :set_form_collections, only: %i[new create edit update]
  before_action :require_admin, except: :show

  def show; end

  def new
    if @episode.result.present?
      redirect_to edit_season_episode_result_path(@season, @episode), notice: "Result already exists."
    else
      @result = @episode.build_result
    end
  end

  def create
    return redirect_to edit_season_episode_result_path(@season, @episode), notice: "Result already exists." if @episode.result.present?

    @result = @episode.build_result(result_params)

    if @result.save
      redirect_to season_episode_result_path(@season, @episode), notice: "Result recorded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return redirect_to new_season_episode_result_path(@season, @episode), notice: "Create the result first." unless @result
  end

  def update
    unless @result
      return redirect_to new_season_episode_result_path(@season, @episode), notice: "Create the result first."
    end

    if @result.update(result_params)
      redirect_to season_episode_result_path(@season, @episode), notice: "Result updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_season
    @season = Season.find(params[:season_id])
  end

  def set_episode
    @episode = @season.episodes.find(params[:episode_id])
  end

  def set_result
    @result = @episode.result
  end

  def set_form_collections
    @contestants = contestants_for(@season)
  end

  def result_params
    params.require(:result).permit(:star_baker_id, :technical_winner_id, :handshake_id, :eliminated_id)
  end
end
