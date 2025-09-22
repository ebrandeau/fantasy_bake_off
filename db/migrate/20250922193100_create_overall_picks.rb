class CreateOverallPicks < ActiveRecord::Migration[7.1]
  def change
    create_table :overall_picks do |t|
      t.references :user,   null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true

      # Point winner_id at contestants table
      t.references :winner, null: false, foreign_key: { to_table: :contestants }

      t.timestamps
    end

    add_index :overall_picks, [:user_id, :season_id], unique: true
  end
end
