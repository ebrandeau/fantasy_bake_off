class CreateEpisodes < ActiveRecord::Migration[8.0]
  def change
    create_table :episodes do |t|
      t.references :season, null: false, foreign_key: true
      t.integer :number
      t.date :air_date

      t.timestamps
    end
  end
end
