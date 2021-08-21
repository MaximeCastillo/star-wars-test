class AddSwapiIdToPlanetsAndMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :planets, :swapi_id, :integer
    add_column :movies, :swapi_id, :integer
  end
end
