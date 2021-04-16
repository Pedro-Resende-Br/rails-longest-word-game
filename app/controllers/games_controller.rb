require 'open-uri'

class GamesController < ApplicationController
  def new
   @letters = (0..(9 - 1)).to_a.map { |_x| ("A".."Z").to_a.sample(1)[0] }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_response = open(url).read
    response = JSON.parse(word_response)
    #raise
    condition = params[:word].chars.all? { |character| params[:word].count(character) <= params[:letters].split("").count(character.upcase) }
    if condition
      if response["found"]
        @answer = "Congratulations"
        @score = response["length"] * 42
      else
        @answer = "Not a english word"
        @score = 0
      end
    else
      @answer = "Not in the grid"
      @score = 0
    end
  end
end
