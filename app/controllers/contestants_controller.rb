class ContestantsController < ApplicationController
  before_action :require_login
  before_action :set_season
  before_action :set_contestant, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

  def index
    @contestants = @season.contestants.order(:name)
  end

  def show; end

  def new
    @contestant = @season.contestants.new
  end

  def edit; end

  def create
    @contestant = @season.contestants.new(contestant_params)

    if @contestant.save
      redirect_to season_path(@season), notice: "Contestant added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @contestant.update(contestant_params)
      redirect_to season_path(@season), notice: "Contestant updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contestant.destroy
    redirect_to season_path(@season), notice: "Contestant removed.", status: :see_other
  end

  private

  def set_season
    @season = Season.find(params[:season_id])
  end

  def set_contestant
    @contestant = @season.contestants.find(params[:id])
  end

  def contestant_params
    params.require(:contestant).permit(:name, :eliminated)
  end
end
