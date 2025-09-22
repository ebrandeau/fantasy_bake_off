class CreateContestants < ActiveRecord::Migration[8.0]
  def change
    create_table :contestants do |t|
      t.references :season, null: false, foreign_key: true
      t.string :name
      t.boolean :eliminated

      t.timestamps
    end
  end
end
