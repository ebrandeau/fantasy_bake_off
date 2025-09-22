class CreateResults < ActiveRecord::Migration[7.1] # keep your version
  def change
    create_table :results do |t|
      # put the unique index here
      t.references :episode, null: false, foreign_key: true, index: { unique: true }

      t.references :star_baker,        null: true, foreign_key: { to_table: :contestants }
      t.references :technical_winner,  null: true, foreign_key: { to_table: :contestants }
      t.references :handshake,         null: true, foreign_key: { to_table: :contestants }
      t.references :eliminated,        null: true, foreign_key: { to_table: :contestants }

      t.timestamps
    end

  end
end
