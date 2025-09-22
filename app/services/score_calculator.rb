class ScoreCalculator
  STAR   = 3
  TECH   = 2
  HAND   = 1
  WINNER = 10

  def self.user_points(user:, season:)
    points = 0

    season.episodes.includes(:result).find_each do |episode|
      result = episode.result
      next unless result

      pick = Pick.find_by(user:, episode:)
      next unless pick

      points += STAR if result.star_baker_id == pick.star_baker_id && result.star_baker_id.present?
      points += TECH if result.technical_winner_id == pick.technical_winner_id && result.technical_winner_id.present?
      points += HAND if result.handshake_id == pick.handshake_id && result.handshake_id.present?
    end

    if season.winner_contestant_id.present?
      if (overall_pick = OverallPick.find_by(user:, season:))
        points += WINNER if overall_pick.winner_id == season.winner_contestant_id
      end
    end

    points
  end
end
