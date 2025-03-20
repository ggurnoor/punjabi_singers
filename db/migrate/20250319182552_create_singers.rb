class CreateSingers < ActiveRecord::Migration[7.0]
  def change
    create_table :singers do |t|
      t.string :name
      t.date :birthdate
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
