require 'rest-client'
require 'json'
require 'pry'


class Search

  attr_accessor :character, :films_arr, :character_hash
  attr_reader :films

  def initialize(character)
    @character = character
    @films_arr = get_character_movies_from_api

  end

  def films
    list = []
    @films_arr.each do |url|
      info = RestClient.get(url)
      film_hash = JSON.parse(info)
      list<<film_hash["title"]
    end
    list.each  {|title| puts "#{list.index(title)+1} #{title}" }
      binding.pry
  end

private

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

  def get_character_movies_from_api
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
          end



end







  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.





## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
