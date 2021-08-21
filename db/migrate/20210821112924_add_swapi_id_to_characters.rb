class AddSwapiIdToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :swapi_id, :integer
  end
end
