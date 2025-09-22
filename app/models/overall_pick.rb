class OverallPick < ApplicationRecord
  belongs_to :user
  belongs_to :season
  belongs_to :winner, class_name: "Contestant"

  validates :user, :season, :winner, presence: true
  validates :season_id, uniqueness: { scope: :user_id }

  validate :winner_matches_season

  private

  def winner_matches_season
    return if winner.nil? || season.nil?

    errors.add(:winner, "must belong to the same season") if winner.season_id != season_id
  end
end
