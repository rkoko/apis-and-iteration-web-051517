require 'rest-client'
require 'json'
require 'pry'


def get_info
  x=1
  all =[]
  while x < 10
    all_characters= RestClient.get("http://www.swapi.co/api/people/?page=#{x}")
    character_hash = JSON.parse(all_characters)
    all.concat(character_hash["results"])
    x+=1
  end
  return all
end


def get_character_movies_from_api(character)
  #make the web request
  character_hash = get_info
  film_list = []
    character_hash.each do |char|
      if character == char["name"].downcase
          char["films"].each do |url|
            film_list << url
          end
          end
        end
        film_list

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  titles = []
  films_hash.each do |url|
    films = RestClient.get(url)
    films_parsed =  JSON.parse(films)
    titles<<films_parsed["title"]
    puts "#{films_hash.index(url)+1} #{films_parsed["title"]}"

  end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
