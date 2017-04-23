class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :spotify_identifier
      t.string :name

      t.timestamps
    end
  end
end
