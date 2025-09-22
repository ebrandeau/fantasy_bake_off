class Result < ApplicationRecord
  belongs_to :episode
  belongs_to :star_baker, class_name: "Contestant", optional: true
  belongs_to :technical_winner, class_name: "Contestant", optional: true
  belongs_to :handshake, class_name: "Contestant", optional: true
  belongs_to :eliminated, class_name: "Contestant", optional: true

  validates :episode_id, uniqueness: true

  validate :contestants_match_episode_season

  private

  def contestants_match_episode_season
    return if episode.blank? || episode.season.blank?

    {
      star_baker: star_baker,
      technical_winner: technical_winner,
      handshake: handshake,
      eliminated: eliminated
    }.each do |role, contestant|
      next if contestant_belongs_to_season?(contestant, episode.season)

      errors.add(role, "must belong to the same season as the episode")
    end
  end

  def contestant_belongs_to_season?(contestant, season)
    contestant.nil? || contestant.season_id == season.id
  end
end
