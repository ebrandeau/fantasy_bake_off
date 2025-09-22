class CreatePicks < ActiveRecord::Migration[7.1]  # your version may differ; keep what was generated
  def change
    create_table :picks do |t|
      t.references :user,    null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.references :star_baker,      null: true, foreign_key: { to_table: :contestants }
      t.references :technical_winner, null: true, foreign_key: { to_table: :contestants }
      t.references :handshake,        null: true, foreign_key: { to_table: :contestants }

      t.timestamps
    end

    add_index :picks, [:user_id, :episode_id], unique: true
  end
end
