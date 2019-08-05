require 'open-uri'

class GamesController < ApplicationController
  def new
    letters = ("A".."Z").to_a
    grid = []
    8.times do
      grid << letters.sample
    end
    @grid = grid.join
  end

  def score
    result = ""
    grid_tab = params[:grid].split("")
    letters = params[:word].upcase.split("")
    str_data = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    hash_data = JSON.parse(str_data.read)
    letters.each do |letter|
      if grid_tab.include? letter
        grid_tab.delete(letter)
      else result = "invalid letters"
      end
    end
    if result == ""
      if hash_data['found']
        result = "#{params[:word]} is a valid word"
      else
        result = "invalid english word"
      end
    end
  @result = result
  end
end
