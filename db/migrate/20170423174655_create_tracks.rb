class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.references :artist, foreign_key: true
      t.references :album, foreign_key: true
      t.string :spotify_identifier
      t.string :name
      t.string :isrc
      t.integer :duration

      t.timestamps
    end
  end
end
