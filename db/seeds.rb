# Seed data for Fantasy Bake Off demo environment

Season.transaction do
  season = Season.find_or_create_by!(year: 2025) do |s|
    s.active = true
  end

  season.update!(active: true)

  admin_users = [
    { name: "Prue Pickwell", email: "prue@example.com", is_admin: true },
    { name: "Paul Hollywood", email: "paul@example.com", is_admin: true }
  ]

  player_users = [
    { name: "Ruby Batter", email: "ruby@example.com" },
    { name: "Liam Whisk", email: "liam@example.com" }
  ]

  (admin_users + player_users).each do |attrs|
    user = User.find_or_initialize_by(email: attrs[:email])
    user.name = attrs[:name]
    user.is_admin = attrs[:is_admin] || false
    user.save!
  end

  contestants = [
    "Avery Frost",
    "Bianca Whisk",
    "Carson Crumb",
    "Daria Swirl",
    "Elliot Ganache",
    "Freya Meringue"
  ].map do |name|
    season.contestants.find_or_create_by!(name:) { |c| c.eliminated = false }
  end

  winner = contestants.first
  season.update!(winner_contestant: winner)

  episodes = [
    { number: 1, air_date: Date.today.beginning_of_week - 7.days },
    { number: 2, air_date: Date.today.beginning_of_week },
    { number: 3, air_date: Date.today.beginning_of_week + 7.days }
  ].map do |attrs|
    season.episodes.find_or_create_by!(number: attrs[:number]) do |episode|
      episode.air_date = attrs[:air_date]
    end
  end

  episode_one = episodes.first
  star_baker = contestants[0]
  technical_winner = contestants[1]
  handshake = contestants[2]
  eliminated = contestants.last

  result = Result.find_or_initialize_by(episode: episode_one)
  result.update!(
    star_baker: star_baker,
    technical_winner: technical_winner,
    handshake: handshake,
    eliminated: eliminated
  )

  users = User.order(:email)
  users.each do |user|
    overall_pick_winner = user.email == "ruby@example.com" ? winner : contestants[3]
    overall_pick = OverallPick.find_or_initialize_by(user:, season:)
    overall_pick.update!(winner: overall_pick_winner)

    pick = Pick.find_or_initialize_by(user:, episode: episode_one)
    pick.update!(
      star_baker: user.email == "ruby@example.com" ? star_baker : contestants[4],
      technical_winner: user.email == "liam@example.com" ? contestants[2] : technical_winner,
      handshake: handshake
    )
  end

  puts "Seeded seasons: #{Season.count}"
  puts "Contestants in season #{season.year}: #{season.contestants.count}"
  puts "Episodes in season #{season.year}: #{season.episodes.count}"
  puts "Users: #{User.count} (Admins: #{User.where(is_admin: true).count})"
  puts "Overall picks: #{OverallPick.count}"
  puts "Episode picks: #{Pick.count}"
  puts "Results recorded: #{Result.count}"
end
