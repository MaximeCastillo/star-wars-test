class CharactersController < ApplicationController
  def index
    @data = []
    
    films = get("http://5.196.14.171:8000/api/films")['results']
    puts "$"*100
    films.each do |film|
      @data.push({
        'film_title' => film['title'],
        'characters' => film['characters']
      })
    end
    puts @data.class
    p @data
  end
end
