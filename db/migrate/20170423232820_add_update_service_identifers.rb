class AddUpdateServiceIdentifers < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :setlistfm_identifer, :string
    add_index :tracks, :spotify_identifier, unique: true
    add_index :artists, :spotify_identifier, unique: true
    add_index :albums, :spotify_identifier, unique: true
  end
end
