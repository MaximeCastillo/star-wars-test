# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

api_planets = SWGEM::Planets.new
planets = api_planets.all
planets.each do |planet|
  Planet.create({
    name: planet['name']
  })
end
puts "DB : planets created"

#api_people = SWGEM::People.new
#swgem is limited to first(10) characters, need another solution to get all characters

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
  Character.create({
    name: character['name'],
    mass: character['mass'],
    planet_id: character['homeworld'].gsub(/\D/, "").to_i,
    swapi_id: character['url'].gsub(/\D/, "").to_i
  })
end
puts "DB : characters created"

api_films = SWGEM::Films.new
movies = api_films.all
movies.each do |movie|
  my_movie = Movie.new({
    title: movie['title'],
    episode_id: movie['episode_id']
  })
  movie['characters'].each do |character_url|
    character_id = character_url.gsub(/\D/, "").to_i
    my_movie.characters << Character.where(swapi_id: character_id)
  end
  my_movie.save
end
puts "DB : movies created"