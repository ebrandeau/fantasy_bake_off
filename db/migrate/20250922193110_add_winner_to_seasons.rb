class AddWinnerToSeasons < ActiveRecord::Migration[8.0]
  def change
    add_reference :seasons, :winner_contestant, foreign_key: { to_table: :contestants }
  end
end
