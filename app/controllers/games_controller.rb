require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(0..25)).chr }
  end

  def score
    @grid = params[:letters].delete(' ').downcase.split('')
    @attempt = params[:word].downcase
    @split_word = @attempt.split(//) 
    @split_word.each do |letter|        #This does not work need to fix it!
      if @grid.count(letter) >= @split_word.count(letter)
        @result = true
      else 
        @result = false
      end 
    end
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    word_serialized = open(url).read
    @word = JSON.parse(word_serialized)
    if @word['found'] == false
      return @message = "Sorry but #{@attempt.upcase} does not seem to be a valid English word..."
    elsif @word['found'] == true && @result == false
      return @message = "Sorry but #{@attempt.upcase} cannot be built out of #{@grid}"
    else
      return @message = "Congratz! #{@attempt.upcase} is a valid English word!"
    end
  end
end
