class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :mass
      t.belongs_to :planet, index: true

      t.timestamps
    end
  end
end
