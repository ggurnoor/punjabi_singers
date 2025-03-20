class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.date :release_date
      t.string :genre  # Genre here is stored as a string

      t.timestamps
    end
  end
end
