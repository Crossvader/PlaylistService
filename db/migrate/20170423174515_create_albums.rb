class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :spotify_identifier
      t.string :name
      t.string :release_date
      t.string :release_date_precision

      t.timestamps
    end
  end
end
