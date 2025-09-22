# Fantasy Bake Off

Fantasy Bake Off is a Ruby on Rails web app for running a fantasy league themed around The Great British Bake Off.
Players draft weekly picks, score points automatically based on show results, and compete in league standings.

## Features
- Create or join a fantasy season
- Make weekly picks before each episode airs
- Automatic score calculation from real results
- Standings and leaderboards update after each episode
- Admin UI for entering episode outcomes

## Requirements

- Ruby 3.4.2
- Rails (7.x recommended)
- PostgreSQL

# Install dependencies
bundle install

# Set up the database
bin/rails db:create db:migrate db:seed

# Start the server
bin/rails s

## Sample URLs

- Home: http://localhost:3000/
- Season: http://localhost:3000/seasons/1
- Episode: http://localhost:3000/seasons/1/episodes/1

## Scoring & Gameplay

Each week, users pick outcomes such as Star Baker, Technical Challenge Winner, and Elimination.
- Picks must be submitted before the episode airs.
- Admins record episode results in the UI.
- A score calculator automatically assigns points:
- Example: Star Baker = +10, Technical Win = +5, Eliminated = –5.
- Leaderboards update instantly once results are entered.

## Roadmap
- user login
- scoring categories
- keep making it more user friendly and visually pleasing