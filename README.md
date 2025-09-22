# Fantasy Bake Off

Fantasy Bake Off is a Rails application for running a fantasy league themed around The Great British Bake Off.

## Requirements

- Ruby 2.6.10
- PostgreSQL

## Setup

```bash
bundle install
bin/rails db:create db:migrate db:seed
bin/rails s
```

## Sample URLs

- Home: http://localhost:3000/
- Season: http://localhost:3000/seasons/1
- Episode: http://localhost:3000/seasons/1/episodes/1

## Scoring & Gameplay

Uses a simple pick system where users choose weekly Star Baker and other outcomes. Points are calculated automatically by the score calculator based on real results. Results are recorded through the UI when episodes finish and users make picks prior to them.

