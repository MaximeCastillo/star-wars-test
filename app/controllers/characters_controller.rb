class CharactersController < ApplicationController
  def index
    @data = []

    films = get("http://5.196.14.171:8000/api/films")['results']
    puts "$"*100
    films.each do |film|
      filtered_characters = []
      film['characters'].each do |people_url|
        character = get(people_url)
        filtered_characters.push(character) if (character['mass'].to_f > 75)
      end
      @data.push({
        'film_title' => film['title'],
        'filtered_characters' => filtered_characters
      })
    end
    puts @data.class
    p @data
  end
end
