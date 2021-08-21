puts "Seeding the database..."

api_planets = SWGEM::Planets.new
planets = api_planets.all
planets.each do |planet|
  Planet.create({
    name: planet['name'],
    swapi_id: planet['url'].gsub(/\D/, "").to_i
  })
end
puts "- planets"

#api_people = SWGEM::People.new
#swgem is limited to first page of 10 characters -> need another solution to get all characters

include RequestHelper

characters_count = get("https://swapi.dev/api/people")['count']
pages_count = (characters_count.to_f / 10).ceil

people_page_url = 'https://swapi.dev/api/people/?page='
characters = []

pages_count.times do |page|
  page_characters = get(people_page_url + (page + 1).to_s)['results']
  characters.concat(page_characters)
end

characters.each do |character|
  my_character = Character.new({
    name: character['name'],
    mass: character['mass'],
    swapi_id: character['url'].gsub(/\D/, "").to_i
  })
  planet_id = character['homeworld'].gsub(/\D/, "").to_i
  my_character.planet = Planet.find_by_swapi_id(planet_id)
  my_character.save
end
puts "- characters"

api_films = SWGEM::Films.new
movies = api_films.all
movies.each do |movie|
  my_movie = Movie.new({
    title: movie['title'],
    episode_id: movie['episode_id'],
    swapi_id: movie['url'].gsub(/\D/, "").to_i
  })
  movie['characters'].each do |character_url|
    character_id = character_url.gsub(/\D/, "").to_i
    my_movie.characters << Character.find_by_swapi_id(character_id)
  end
  my_movie.save
end
puts "- movies"

puts "Seeding is done."