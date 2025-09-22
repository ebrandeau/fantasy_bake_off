class Episode < ApplicationRecord
  belongs_to :season
  belongs_to :star_baker, class_name: "Contestant", optional: true
  belongs_to :technical_winner, class_name: "Contestant", optional: true
  belongs_to :handshake, class_name: "Contestant", optional: true
  belongs_to :eliminated, class_name: "Contestant", optional: true

  has_many :picks, dependent: :destroy
  has_one :result, dependent: :destroy

  validates :number, presence: true, numericality: { only_integer: true }
  validate :result_contestants_match_season

  private

  def result_contestants_match_season
    return if season.blank?

    {
      star_baker: star_baker,
      technical_winner: technical_winner,
      handshake: handshake,
      eliminated: eliminated
    }.each do |role, contestant|
      next if contestant_belongs_to_season?(contestant, season)

      errors.add(role, "must belong to the same season as the episode")
    end
  end

  def contestant_belongs_to_season?(contestant, season)
    contestant.nil? || contestant.season_id == season.id
  end
end
